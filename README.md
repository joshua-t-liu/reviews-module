## Designing and Scaling the Backend of a Customer Reviews Microservice

### Goal
Designed and scaled the backend of a customer reviews microservice to maintain a load of **1200** RPS under **50** ms latency.  Deployed servers onto AWS which included 1 Nginx server, 2 Express servers, and 1 PostgreSQL server.  The PostgreSQL server included 50 M primary records.  Used Loader.io, New Relic, and CloudWatch to perform and analyze load testing .

*The frontend was developed by a teammate and was developed using React.*


### Technology
 * Express
 * Nginx
 * AWS (t2.micro services)
 * PostgreSQL
 * Loader.io
 * New Relic
 * RedisDB
 * React

### Images
![Customer Reviews](https://github.com/joshua-t-liu/reviews-module/blob/master/images/customer_reviews.png)

### Database Schema
![Image Gallery](https://github.com/joshua-t-liu/reviews-module/blob/master/images/schema.png)

### Reproduction Steps
Assumes PostgreSQL is installed in the local environment.
1. Run ```$ npm install```.
2. Start the PostgreSQL database.
3. Start the POstgreSQL server ```$ sudo service postgresql start```.
4. Enter PostgreSQL CLI ```$ sudo -u postgres psql```.
5. Create the database ```# \i /mnt/c/users/joshua/Desktop/reviews-module/seed/schema.sql```.
   - The filepath will be wherever the file is saved in your local environment.
6. Create a new folder called data in the seed folder ```mkdir ./seed/data```.
7. Create seed data ```$ node ./seed/seed.js```.
7. Import seed data into PostgreSQL ```# \i /mnt/c/users/joshua/Desktop/reviews-module/seed/import_data.sql```.
8. Validate that data successfully imported ```# SELECT * FROM reviews.reviews LIMIT 5```.
9. Add constraints to the database tables ```# \i /mnt/c/users/joshua/Desktop/reviews-module/seed/constraints.sql```.
9. Start the Express server ```node ./index.js```.
10. Click  [link](https://localhost:3003) and check that customer reviews service is working.