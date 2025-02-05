# eMekteb

### Kredencijali za prijavu

DESKTOP:
1. Uloga administrator (Dino Maksumic)
    - username: admin
    - password: test
2. Uloga komisija (Armin Abaza)
    - username: komisija
    - password: test


MOBILE:
1. Uloga imam (Atif Mujkic)
    - username: imam
    - password: test
2. Uloga učenik (Lejla Maric)
    - username: ucenik
    - password: test
3. Uloga roditelj (Zijad Maric)
    - username: roditelj
    - password: test


### RabbitMq
RabbitMQ komunikacija se uspostavlja na desktop dijelu kada admin doda korisnika sa ulogom "komisija" 
prilikom čega se novom korisniku automatski šalje mail u vidu obavijesti za takmičenje.

>[!NOTE]
>### Dodavanje roditelja
>Dodavanje korisnika sa ulogom roditelj se vrši prilikom dodavanja svakog novog učenika.
U slučaju da se dodaje učenik za kojeg je roditelj već kreiran isti se neće ponovo kreirati, 
u tom slučaju se samo povezuje sa još jednim djetetom. 
