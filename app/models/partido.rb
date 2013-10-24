class Partido < ActiveRecord::Base
  include PublicActivity::Common
  
  attr_accessible :diapartido, :local, :logolocal, :logovisitante, :visitante, 
  :terminado, :resultadoLocal, :resultadoVisitante, :cerrado, :repartido, :torneo

  validates :diapartido, presence: true 
  validates :local, presence: true
  validates :visitante, presence: true
  validates :logolocal, presence: true
  validates :logovisitante, presence: true
  validates :torneo, presence: true

  has_many :bets, :dependent => :destroy
  has_many :users, :through => :bets

  def nombre_torneo
    case self.torneo
    when 1
      "Champions League"
    when 2
      "Eliminatoria Sudamericana"
    when 3
      "Copa Libertadores"
    when 4
      "Liga Postobon"
    when 5
      "Liga Espanola"
    when 6
      "Premier League"
    when 7
      "Liga Mexicana"
    when 8
      "liga del Peru"
    end
  end
  
  def hora_partido
    diapartido.strftime("%b %d - %l:%M %p")
  end

  def apuestas_en_el_resultado(local, visitante)
    self.bets.where("\"golesLocal\"= ? AND \"golesVisitante\"= ?",local, visitante)
  end



  def monto_apostado_en_el_resultado(local, visitante)
    return self.apuestas_en_el_resultado(local,visitante).sum(:monto).to_f
  end




  def porcentaje_en_el_resultado(local, visitante, monto_futuro=0)
    montoResultado=self.monto_apostado_en_el_resultado(local, visitante)

    if (montoResultado + monto_futuro)==0
      return -1
    else
      return (montoResultado +monto_futuro)/ (self.monto_total_apostado + monto_futuro)
    end
  end




  def xveces_el_resultado(local, visitante, monto_futuro=0)
    porcentajeResultado =self.porcentaje_en_el_resultado(local,visitante, monto_futuro)
    
    if porcentajeResultado== -1
      return ((1 - 0.4)/self.porcentaje_en_el_resultado(local,visitante, 10000)) 
    else
      return ((1 - 0.4)/porcentajeResultado).round(1)
    end
  end




  def monto_total_apostado
    return self.bets.sum(:monto)
  end





  def monto_que_puedo_apostar_en_el_marcador(local, visitante)
    apuesta=((self.monto_total_apostado * 0.3) - self.monto_apostado_en_el_resultado(local, visitante))/(1-0.3)
    return apuesta
  end






  def supporters_partido(followings, partido)
    amigosLocal=[]
    amigosVisitante=[]
    amigosEmpate=[] 
    arreglos=[]

    followings.each do |fan|
      betSupporter = Bet.where(:user_id=>fan.id).where(:partido_id=>partido.id).first  
      
      if betSupporter==nil
      else

        nombreFan=fan.name
        fotoFan="https://graph.facebook.com/#{fan.uid}/picture"
        marcadorFan="#{partido.local} : #{betSupporter.golesLocal} - #{partido.visitante} : #{betSupporter.golesVisitante}"
        
        if betSupporter.golesLocal>betSupporter.golesVisitante
          as={name: nombreFan, pic: fotoFan, marcador: marcadorFan}
          amigosLocal.push(as)
        else
          if betSupporter.golesLocal<betSupporter.golesVisitante
            as={name: nombreFan, pic: fotoFan, marcador: marcadorFan}
            amigosVisitante.push(as)
          else
            as={name: nombreFan, pic: fotoFan, marcador: marcadorFan}
            amigosEmpate.push(as)
          end 
        end 
      end

    end#End del for.

    as={local: amigosLocal, visitante: amigosVisitante, empate: amigosEmpate}
    #arreglos.push(amigosLocal)
    #arreglos.push(amigosVisitante)
    #arreglos.push(amigosEmpate)
    arreglos.push(as)
    return arreglos
  end




  def repartir_la_plata
    bets_ganadoras = self.apuestas_en_el_resultado(self.resultadoLocal, self.resultadoVisitante)
    bets_ganadoras.each do |bet|
      user = User.find(bet.user_id)
      pezzos_ganados = bet.monto * xveces_el_resultado(self.resultadoLocal, self.resultadoVisitante)
      bet.update_attributes(pezzos_ganados: pezzos_ganados, repartido: true)
      user.consignar_pezzos(pezzos_ganados)
      user.partidos_ganados  += 1 #
      user.partidos_perdidos = user.bets.count - user.partidos_ganados
      user.pezzos_acumulados += pezzos_ganados

      user.save  
    end
  end


  def apuestas_del_usuario(user)
    return self.bets.where(user_id: user.id)
  end




  def ganancias_del_usuario(user)
    ganancias = self.apuestas_del_usuario(user).sum(:pezzos_ganados) 
    if ganancias > 0
      return ganancias
    else
      return (-1 * self.apuestas_del_usuario(user).sum(:monto))
    end
  end




  def ganadores_del_partido
    return self.bets.where("pezzos_ganados is NOT NULL", nil).order("pezzos_ganados DESC")
  end

  def nombre_del_equipo_que_va_a_ganar_la_apuesta(bet)
      if bet.golesLocal> bet.golesVisitante
        "ganando #{self.local}"
      elsif bet.golesLocal<bet.golesVisitante
        "ganando #{self.visitante}"
      else
        "empatando"
      end
  end

  def enviar_email_se_cerro_el_partido
      PartidoMailer.partido_cerrado.deliver
  end

  def to_param
    "#{id}-#{self.local} vs #{self.visitante}"
  end 
end
