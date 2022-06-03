# 1. Creëren van databases en schema’s 
### 1.1 Als eerste creëren we een staging database met de volgende query.

```SQL
CREATE TABLE [Staging];
```
### 1.2 Na het aanmaken van de staging database maken we 3 schema’s aan :

```SQL
CREATE SCHEMA [RAW];
CREATE SCHEMA [ARCHIVED]; 
CREATE SCHEMA [CLEANSED];
```

# 2. Importeren van data

### 2.1 Open SQL server import en export wizard
- We gebruiken deze om files (flat files en Excel bestanden in dit geval) in te laden in onze database zodat vervolgens stored procedures kunnen uitvoeren om deze data op te kuisen [zoals getoond in puntje 4](https://github.com/dev-jens/Data-engineering-Groep-5/#4-data-oversturen-naar-cleansed-tabellen)
<br><br>
<img width="472" alt="image" src="https://user-images.githubusercontent.com/61287853/171653136-5897984d-f444-4900-99c7-2a1c4f91d494.png" >

### 2.2 Kies een data source (bron bestand)
- Kies voor csv of andere bestandstypes “flat file source” en voor Excel bestanden “Microsoft Excel”.
<img width="444" alt="image" src="https://user-images.githubusercontent.com/61287853/171654907-611a5cf2-b327-4e01-914a-9d521deb6617.png">

- Vervolgens kies je het pad van het bestand dat je in de database wilt steken.
<img width="374" alt="image" src="https://user-images.githubusercontent.com/61287853/171655405-4c76e054-876f-42e8-a6af-21d291480a3d.png">

### 2.3 Kies de locatie waar je je file wilt inladen
- Vul je server name in en in welke database we het willen inladen, in ons geval is dit de staging database.
<br>

<strong> NOTE : </strong> Bij een flat source kan je ook nog de lengte van het aantal charachters, etc. aanpassen bij Advanced > kolomnaam > OutputColumnWidth (wij in deze tutorial hebben wel alles om 150 gezet).  <br>

<p>
<img width="350" alt="image" src="https://user-images.githubusercontent.com/61287853/171656388-f1577598-e156-46c9-b4b2-0f309aa0fe71.png">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/61287853/171656470-d0f4ff7a-71ba-4020-b37d-772c38d63e17.png">
</p>

### 2.4 Creëer de tabellen voor in de staging database
- Geef alle tabellen een correcte naam en het RAW-schema mee.
<img width="501" alt="image" src="https://user-images.githubusercontent.com/61287853/171657483-6196fcef-de32-4583-8fbc-e3f2197f7ce7.png">

### 2.5 Druk op finish en bekijk het resultaat
<img width="320" alt="image" src="https://user-images.githubusercontent.com/61287853/171657936-a6dd12f4-f377-45dd-8951-e72aa6eba14b.png">
</br>

<h3> <strong>Note : </strong> Herhaal deze stappen voor alle files.  </h3>

</br>

# 3. Creëren van Cleansed- en Archived-tabellen
### 3.1 Creëer de cleansed en archived databases met de volgende scripts.
- [createCLEANSED.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/createCLEANSED.sql)
- [createARCHIVED.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/createARCHIVED.sql)

# 4. Data oversturen naar CLEANSED tabellen.
### 4.1 Voer al deze scripts uit om correcte data over te sturen naar de cleansed en incorrecte data over te sturen naar de archived tabellen.
- [move_Categories.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/move_Categories.sql)
- [move_Customers.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/move_Customers.sql)
- [move_Order.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/move_Order.sql)
- [move_OrderDetails.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/move_OrderDetails.sql)
- [move_Product.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/move_Product.sql)
- [move_Shippers.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/move_Shippers.sql)
- [move_Suppliers.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/move_Suppliers.sql)

Voer het script sp_CREATE_FK.sql uit, na het versturen van de data. Zodat alle foreign keys voor de cleansed tabel worden gecreëerd.
- [sp_CREATE_FK.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/sp_Create_FK.sql)

# 5. SSIS
- Creëer de database SeaShippers_DWH aan de hand van deze query:
 ```SQL
 CREATE DATABASE [SeaShippers_DWH]
 ```
- Voer Startcode_DWH uit
  - [Startcode_DWH.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/Sterschema/SterSchemaPNG.png)

- Creëer de dim en fact tabellen die gebaseerd zijn op ons ster diagram.
  - [ster_diagram](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/Sterschema/SterSchemaPNG.png)
  - [sp_Create_Dim_and_FactTables.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/sp_CreateDim_and_Fact.sql)

- Voer nu de ssis packages uit. 
  <br><br>
<strong> NOTE : </strong> Belangrijk bij het uitvoeren van de packages is dat je de FACT.Orders als laatste uitvoert. Deze gebruikt de Geo_id van DIM_Location, daarom is het noodzakelijk deze als laatste uit te voeren.

- Voer als laatste het script uit om de Foreign keys te creëeren voor de datawarehouse.
  - [sp_create_FK_DWH.sql](https://github.com/dev-jens/Data-engineering-Groep-5/blob/master/SQL%20bestanden/sp_create_FK_DWH.sql)

# 6.Power BI
### 6.1 Data importeren in Power BI
- Nu dat we de datawarehouse hebben gevuld kunnen we deze gegevens importeren in Power BI om de data te visualiseren


- Kies SQL Server-database voor de manier waarop je de gegevens gaat ophalen.


- Geef dan de naam van je SQL Server in en de Database waarvan je de gegevens wilt importeren.


- Selecteer alle Dimensie tabellen en de Fact tabel en druk op 'Laden'. Hierna wordt de data ingeladen en kan je ze gebruiken in de visualisatie.


### 6.1 Visualisaties

- Om een visualisatie toe te voegen kies je er een uit de lijst en vul je hier de gewenste data in. 

- Je hebt ook nog de optie om extra kolommen toe te voegen, dit is mogelijk in de query editor. Hier kan je kolommen toevoegen van andere tabellen of nieuwe kolommen maken op basis van berekeningen of voorwaarden.
=

