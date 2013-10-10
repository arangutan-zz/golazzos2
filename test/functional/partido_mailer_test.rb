require 'test_helper'

class PartidoMailerTest < ActionMailer::TestCase
  test "partido_termino" do
    mail = PartidoMailer.partido_termino
    assert_equal "Partido termino", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "ganadores_del_partido" do
    mail = PartidoMailer.ganadores_del_partido
    assert_equal "Ganadores del partido", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
