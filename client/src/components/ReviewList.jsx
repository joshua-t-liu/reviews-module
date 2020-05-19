import React, { Fragment } from 'react';
import styled from 'styled-components';
import ReviewListEntry from './ReviewListEntry.jsx';

const ToggleMenu = styled.ul`
display: flex;
width: 100%;
padding: 0;
margin: 0 0 14px 0;
list-style: none;
`;

const MenuItem = styled.li`
flex-basis:0;
flex-grow: 1;
margin-bottom: 14px;
&:first-child {
  margin-left: 0;
}
border: 1px solid #767677;
`;

const Button = styled.button`

  font-size: 14px;
  font-family: AdihausDIN,Helvetica,Arial,sans-serif;
  text-transform: uppercase;
  font-weight: 700;
  letter-spacing: 2px;

  cursor: pointer;
  padding: 16px 10px;

  transition: color .1s cubic-bezier(.3,0,.45,1);
  width: 100%;
  margin: 0;
  background: none;
  border: none;
  &:focus {
    outline: none;
  }
  &:hover {
    border-color: #767677;
    color: #767677;
  }
`;

const FooterControls = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  margin: 40px 0 2px 0;
`;

const LoadButton = styled.button`
font-size: 13px;
font-family: AdihausDIN,Helvetica,Arial,sans-serif;
text-transform: uppercase;
font-weight: 700;
letter-spacing: 2px;
  
margin-top: 0;
width: 50%;
margin-right: 10px;
height: 50px;
padding: 0 21px;

background-color: #fff;
border: 1px solid #000;
color: #000;

align-items: center;
border-radius: 0;
cursor: pointer;
display: inline-flex;
justify-content: space-between;
line-height: 50px;
min-height: 50px;
padding: 0 21px;
position: relative;
text-align: left;
text-decoration: none;
transition: transform .1s cubic-bezier(.3,0,.45,1),color .1s cubic-bezier(.3,0,.45,1),border .1s cubic-bezier(.3,0,.45,1),background .1s cubic-bezier(.3,0,.45,1);
white-space: nowrap;
cursor: pointer;
&:hover {
border-color: #000;
color: #767677;
}
&:active {
transform: scale(.97);
}
&:focus {
outline: none;
}
`;

const WriteButton = styled.button`
box-sizing: border-box;
display: flex;
font-size: 13px;
font-family: AdihausDIN,Helvetica,Arial,sans-serif;
text-transform: uppercase;
font-weight: 700;
letter-spacing: 2px;

margin-top: 0;
width: 50%;
margin-right: 10px;
height: 50px;
padding: 0 21px;

background-color: black;
border: none;
color: white;
box-shadow: 3px 3px 0 0px white, 3px 3px 0 1px black;

vertical-align: middle;
align-items: center;
justify-content: space-between;
position: relative;
top: -2px;
cursor: pointer;
&:hover {
  color: gray;
}
&:active {
  transform: translateY(3px) translateX(3px);
  box-shadow: none;
}
&:focus {
  outline: none;
}
`;

const StyledPathArrow = styled.path`
  padding: 0px;
  margin-top: 0px;
  stroke-linecap: square;
  stroke-width: 2px;
  vertical-align: text-top;
  d: path(${props => props.d});
`;


class ReviewList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      
    };
  }

  render() {
    return (
      <Fragment>
        <div className="sort">
          <ToggleMenu>
            <MenuItem><Button>newest</Button></MenuItem>
            <MenuItem><Button>helpful</Button></MenuItem>
            <MenuItem><Button>relevant</Button></MenuItem>
          </ToggleMenu>
        </div>
        {this.props.reviews.map((review) => 
          <ReviewListEntry key={review.id} review={review}/>
        )}
        <FooterControls>
          <LoadButton>
            <span>load more</span>
            <svg height="25px" width="25px">
              <g fill="none" stroke="currentColor" strokeMiterlimit="10">
                <StyledPathArrow d="M17.59 7l5 5-5 5M0 12h22"></StyledPathArrow>
              </g>
            </svg>
          </LoadButton>
          <WriteButton>
            <span>write a review</span>
            <svg height="25px" width="25px">
              <g fill="none" stroke="currentColor" strokeMiterlimit="10">
                <StyledPathArrow d="M17.59 7l5 5-5 5M0 12h22"></StyledPathArrow>
              </g>
            </svg>
          </WriteButton>
        </FooterControls>
      </Fragment>
    );
  }
}

export default ReviewList;