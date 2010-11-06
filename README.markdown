# SinSMS

SinSMS to prosta aplikacja pozwalająca na wysyłanie SMS-ów przez bramkę SMS-ową (wykorzystuje do tego [skrypt Michała Kurka](https://github.com/oki/sms)).

Aplikacja ta powstała po to, by wysyłanie SMS-ów stało się jeszcze prostsze. Po uruchomieniu SinSMS na serwerze możesz wysyłać SMS-y z praktycznie każdej komórki za pośrednictwem internetu.

Do wysyłania SMS-ów "wykorzystywana" jest bramka [sms.priv.pl](http://sms.priv.pl), warto zapoznać się z jej ograniczeniami.

## Instalacja

    git clone git://github.com/ravicious/sinsms.git
    cd sinsms
    bundle install
    cp credentials.yml.example credentials.yml

Po wklepaniu tych poleceń musisz jeszcze wyedytować plik `credentials.yml` w celu ustawienia nazwy użytkownika i hasła dostępu - chyba nie chcesz, żeby każdy mógł wysyłać SMS-y z Twojej instacji SinSMS?
