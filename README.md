# eMekteb

### Kredencijali za prijavu

DESKTOP (uloge administrator i komisija):

- username: admin 
- password: test

- username: komisija
- password: test


MOBILE (uloge imam, ucenik i roditelj):

- username: imam
- password: test

- username: ucenik
- password: test

- username: roditelj
- password: test

### RabbitMq
RabbitMQ komunikacija se uspostavlja na desktop dijelu kada admin doda korisnika sa ulogom "komisija" 
prilikom čega se novom korisniku automatski šalje mail u vidu obavijesti za takmičenje.


### Dodavanje roditelja
>[!NOTE]
>Dodavanje korisnika sa ulogom roditelj se vrši prilikom dodavanja svakog novog učenika.
U slučaju da se dodaje učenik za kojeg je roditelj već kreiran isti se neće ponovo kreirati, 
u tom slučaju se samo povezuje sa još jednim djetetom. 
