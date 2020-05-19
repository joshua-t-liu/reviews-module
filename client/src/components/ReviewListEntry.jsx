import React, { Fragment } from 'react';
import styled from 'styled-components';

const CollectionItem = styled.div`
    border-bottom: 1px solid #000;
    position: relative;
    padding-bottom: 40px;
    margin-top: 40px;`;
const Stars = styled.div`
color: #767677;
display: inline-flex;
`;
const Time = styled.div`
    position: absolute;
    right: 0;
    top: 0;
    color: #767677;
    font-size: 14px;
    line-height: 20px;
    margin: 0 0 14px 0;
    `;
const Title = styled.header`
margin: 20px 0 0 0;
padding: 0;
font-size: 18px;
    line-height: 16px;
    font-family: AdineuePRO,Helvetica,Arial,sans-serif;
    font-style: normal;
    font-weight: 600;
    text-transform: uppercase;
    `;
const Text = styled.div`
margin-top: 10px 0 0 0;
`;
const Recommend = styled.span`
margin-top: 20px 0 0 0;`;
const DontRecommend = styled.span`
display: none;
margin: 20px 0 0 0;
`;
const User = styled.div`
    text-transform: uppercase;
    font-family: AdihausDIN,Helvetica,Arial,sans-serif;
    font-weight: 700;
    font-size: 14px;
    line-height: 20px;
    margin: 10px 0 14px 0;
`;

const ReviewListEntry = (props) => (
  <CollectionItem>
    <Stars>★★★★★</Stars>
    <Time>April 30, 2020</Time>
    <Title>{props.review.title}</Title>
    <Text>{props.review.text}</Text>
    <Recommend>✓ I recommend this product</Recommend>
    <DontRecommend>x I do not recommend this product</DontRecommend>
    <User>{props.review.user_nickname}</User>
    <div>Was this review helpful? Yes (0) No (0)</div>
  </CollectionItem>
);

export default ReviewListEntry;

/*
<Fragment>
  <div>★★★★☆ April 30, 2020</div>
  <div>Title: Awesome shoe!</div>
  <div>Text: Comfortable, it has great style</div>
  <div>✓I recommend this product</div>
  <div>user: vanesa4</div>
  <div>Was this review helpful? Yes (0) No (0)</div>
  <div>---------------------------------------</div>
</Fragment>
*/