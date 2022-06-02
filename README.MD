# 1. Creëren van databases en schema’s 
- Als eerste creëren we een staging database met de volgende query.

```sql
CREATE TABLE [Staging];
```

- Na het aanmaken van de staging database maken we 3 schema’s aan :
```SQL
CREATE SCHEMA [RAW];
CREATE SCHEMA [ARCHIVED]; 
CREATE SCHEMA [CLEANSED];
```

# 2. Importeren van data
## 2.1 Open SQL server import en export wizard
We gebruiken deze om files (flat files en Excel bestanden in dit geval) in te laden in onze database zodat vervolgens stored procedures kunnen uitvoeren om deze data op te kuisen [zoals getoont in puntje 4]()


## 2.2 kies een data source (bron bestand)
Kies voor csv of andere bestandstypes “flat file source” en voor Excel bestanden “Microsoft Excel”

## 2.3 kies het pad van het bestand dat je in de database wilt steken

## 2.4 kies de locatie waar je je file wilt inladen
Vul je server name in en in welke database we het willen inladen in ons geval is dat de staging database
<br>

<strong> NOTE : bij een flat source kan je ook nog de lengte van het aantal charachters, etc. aanpassen bij Advanced > kolomnaam > OutputColumnWidth (wij in deze tutorial hebben wel alles om 150 gezet) </strong> <br>

## 2.5 creëer de tabellen voor in de staging database
- Geef alle tabellen een correcte naam en het RAW-schema mee.

## 2.6 druk op finish en bekijk het resultaat

</br>

### <b> Herhaal deze stappen voor alle files. </b>
</br>

# 3. creëren van Cleansed- en Archived-tabellen
- Run het script createCLEANSED.sql <br>
- Run het script createARCHIVED.sql

# 4. data oversturen naar CLEANSED tabellen.
Voer al deze scripts uit om correcte data over te sturen naar de cleansed en incorrecte data over te sturen naar de archived tabellen.
move_Categories.sql
move_Customers.sql
move_Order.sql
move_OrderDetails.sql
move_Product.sql
move_Shippers.sql
move_Suppliers.sql
Voer het script sp_CREATE_FK.sql uit, na het versturen van de data. Zodat alle foreign keys voor de cleansed tabel worden gecreëerd.
5. ssis

voer sp_startcode_dwh uit
voer dim_en fact uit
 Voer nu de ssis packages uit.
NOTE: Belangrijk bij het uitvoeren van de packages is dat je de FACT.orders als laatste uitvoert. Deze gebruikt de Geo_id van dim_location daarom is het noodzakelijk deze als laatste uit te voeren

voer het script sp_create_FK_DWH.sql uit

6.power BI
