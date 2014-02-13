class Partido < ActiveRecord::Base
  include PublicActivity::Common
  
  attr_accessible :diapartido, :local, :logolocal, :logovisitante, :visitante, 
  :terminado, :resultadoLocal, :resultadoVisitante, :cerrado, :repartido, :torneo,
  :email_partido_cerrado, :email_partido_terminado, :id

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
    when 9
      "Amistosos"
    when 10
      "Repechaje"
    end
  end

  def self.torneos
    [
      ["Todos los torneos", 0],
      ["Champions League",1],
      ["Eliminatoria Sudamericana",2],
      ["Copa Libertadores",3],
      ["Liga Postobon",4],
      ["Liga Espanola",5],
      ["Premier League", 6],
      ["Liga Mexicana",7],
      ["Liga del Peru",8],
      ["Amistosos",9],
      ["Repechaje",10]
    ]
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

  def self.minimo_total
    500000
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

def puedo_apostar_en_el_marcador?(local, visitante, monto_futuro=0)

    if self.monto_total_apostado<= Partido.minimo_total
      true
    elsif xveces_el_resultado(local, visitante, monto_futuro)>= 2
      true
    else
      false
    end
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

  def self.enviar_email_partido_cerrado(partido)
    if partido.email_partido_cerrado==false
      partido.update_attributes(email_partido_cerrado: true)
      users = partido.users.uniq
          users.each do |user|
            bets= partido.apuestas_del_usuario(user)
            #PartidoMailer.email_prueba(user).deliver
            PartidoMailer.partido_cerrado(partido, user, bets ).deliver
      end  
    end
  end

  def self.enviar_email_nueva_apuesta(user,bet)
    PartidoMailer.email_apuesta_realizada(user, bet).deliver
  end

  def self.enviar_email_partido_terminado(partido)
      if partido.email_partido_terminado==false
          partido.update_attributes(email_partido_terminado: true)
          users = partido.users.uniq
          users.each do |user|
              bets = partido.apuestas_del_usuario(user)
              if partido.ganancias_del_usuario(user)>0
                #enviar email de ganaste
                PartidoMailer.ganador_del_partido(partido, user, bets ).deliver
              else
                #enviar email de perdiste 
                PartidoMailer.perdedor_del_partido(partido, user, bets ).deliver
              end
          end
      end
  end

  def to_param
    "#{id}-#{self.local}_vs_#{self.visitante}_partidoid"
  end 
end
