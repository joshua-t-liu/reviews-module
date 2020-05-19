import React, { Fragment } from 'react';
import styled from 'styled-components';
import RatingTallyEntry from './RatingTallyEntry.jsx';

const StarRating = styled.div`
width: 100%;
height: 100px;
display: flex;
justify-content: center;
align-items: center;
background-color: #2ada71;
`;
const OutofFive = styled.div`
font-size: 56px;
font-weight: 700;
text-align: right;
padding-right: 8px;
`;
const Stars = styled.div`
flex-flow: column wrap;
justify-content: space-between;
padding: 8px 0 8px 8px;
`;
const RatingBreakdown = styled.div`
border-bottom: 1px solid #ebedee;
padding-bottom: 20px;
margin-top: 20px;
`;
const Header = styled.header`
font-size: 18px;
line-height: 16px;
font-family: AdineuePRO,Helvetica,Arial,sans-serif;
font-style: normal;
font-weight: 600;
margin-bottom: 20px;
text-transform: uppercase;
`;

class RatingTally extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <>
        <StarRating>
          <OutofFive>4.7</OutofFive>
          <Stars>
            <div>★★★★★</div>
            <div><strong>6860</strong> Reviews</div>
          </Stars>
        </StarRating>
        <RatingBreakdown>
          <Header>rating breakdown</Header>
          <RatingTallyEntry star={5} percent={76.65} count={5253}/>
          <RatingTallyEntry star={4} percent={17} count={1192}/>
          <RatingTallyEntry star={3} percent={3} count={244}/>
          <RatingTallyEntry star={2} percent={1} count={75}/>
          <RatingTallyEntry star={1} percent={2} count={101}/>
        </RatingBreakdown>
      </>
    );
  }
}

export default RatingTally;