class Profile < ActiveRecord::Base
  attr_accessible :camiseta_de, :celular, :ciudad, :direccion, :email, :equipos_favoritos, 
  					:nombre, :pais, :talla, :twitter, :num_visitas, :apostaria

  #validates :camiseta_de, presence: true
  #validates :celular, presence: true
  #validates :ciudad, presence: true
  #validates :direccion, presence: true
  #validates :email, presence: true
  #validates :equipos_favoritos, presence: true
  #validates :pais, presence: true
  #validates :talla, presence: true
  #validates :twitter, presence: true

  def aumentar_visitas
    visitas = self.num_visitas + 1
    self.update_attributes(num_visitas: visitas)
  end

  def apostaria?
    return apostaria
  end
end
