const fs = require('fs');
const faker = require('faker');

//for mysql
// 100k products
// ~200 reviews/ products
// 10M users
// 30M records total


const generateProducts = async () => {
  let ready;
  let j = 1;
  let counter = 1;

  while(j){
    let i = 100000;
    let file = fs.createWriteStream(`./seed/product/seed_product${j}.csv`);
    while(i) {
      ready = file.write(
        counter++ + ',' +
        faker.commerce.productName() +
        '\n');
      if (!ready) {
        await (new Promise((resolve) => file.once('drain', resolve)));
      }
      i--;
    }
    file.end();
    j--;
  }
  console.log('finished seeding products');
};

//create users
const generateUsers = async () => {
  let ready;
  let j = 1;
  let counter = 1;
  while(j){
    let i = 10000000;
    let file = fs.createWriteStream(`./seed/user/seed_user${j}.csv`);
    while(i) {
      ready = file.write(
        counter++ + ',' +
        faker.internet.userName().substring(0,25) + ',' +
        faker.internet.email() + ',' +
        (i % 2 === 0) +
        '\n');
      if (!ready) {
        await (new Promise((resolve) => file.once('drain', resolve)));
      }
      i--;
    }
    file.end();
    j--;
  }
  console.log('finished seeding users');
}

//create reviews
const generateReviews = async () => {
  let ready;
  let j = 10;
  let counter = 1;
  let product_id = 1;
  const ratings = ['poor', 'fair', 'average', 'good', 'great'];
  const ratings_centered = ['too_small', 'small', 'perfect', 'big', 'too_big'];

  while(j) {
    let i = 10000;
    let file = fs.createWriteStream(`./seed/review/seed_review${j}.csv`);

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
        ready = file.write(
          counter++ + ',' + // id
          product_id + ',' +
          faker.random.number({min:1, max:10000000}) + ',' + //user_id 9999999
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
        if (!ready) {
          await (new Promise((resolve) => file.once('drain', resolve)));
        }
        k--;
      }
      i--;
    }
    file.end();
    j--;
    console.log('finished seeding reviews file', j);
  }
}

//generateProducts();
//generateUsers();
generateReviews();
