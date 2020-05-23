const fs = require('fs');
const faker = require('faker');

//for mysql
// 100k products
// ~200 reviews/ products
// 10M users
// 30M records total
let j = 10;
while(j){
  let i = 10;
  let file = fs.createWriteStream(`./SDC/product/seed_product${j}.csv`);
  while(i) {
    file.write(faker.commerce.productName() + '\n');
    i--;
  }
  file.end();
  j--;
}

//create users
j = 10;
while(j){
  let i = 1000000;
  let file = fs.createWriteStream(`./SDC/user/seed_user${j}.csv`);
  while(i) {
    file.write(
      faker.internet.userName().substring(0,25) + ',' +
      faker.internet.email() + ',' +
      (i % 2 === 0) +
      '\n');
    i--;
  }
  file.end();
  j--;
}

//create reviews
let product_id = -1;
const ratings = ['poor', 'fair', 'average', 'good', 'great'];
const ratings_centered = ['too_small', 'small', 'perfect', 'big', 'too_big'];

j = 10;
while(j) {
  let i = 10;
  let file = fs.createWriteStream(`./SDC/review/seed_review${j}.csv`);

  while(i) {
    // 10% 0, 80% 1-500, 5%, 501-1k ,5% 1k-5k
    product_id ++;
    if (i % 10 === 0) {
      k = 0;
    } else if (i % 5 !== 0) {
      k = faker.random.number({min:1, max:500});
    } else {
      k = faker.random.number({min:500, max:5000});
    }

    while(k) {
      file.write(
        product_id + ',' +
        faker.random.number({min:0, max:1000000}) + ',' + //user_id 9999999
        faker.lorem.sentence() + ',' + // title 3-10 words
        faker.lorem.sentences() + ',' + // text 2-6 sentences
        (k % 10 === 0) + ',' + // recommends
        faker.random.arrayElement(ratings) + ',' + // rating_overall
        faker.random.arrayElement(ratings_centered) + ',' + // rating_size
        faker.random.arrayElement(ratings_centered) + ',' + // rating_width
        faker.random.arrayElement(ratings) + ',' + // rating_comfort
        faker.random.arrayElement(ratings) + ',' + // rating_quality
        faker.random.number({min:0, max:50}) + ',' + // is_helpful
        faker.random.number({min:0, max:50}) + ',' + // is_not_helpful
        faker.date.recent(90).toISOString() + // date should be datetime, does it matter???
        '\n');
      k--;
    }

    i--;
  }
  file.end();
  j--;
}


