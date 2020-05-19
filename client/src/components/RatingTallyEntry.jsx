import React, { Fragment } from 'react';
import styled from 'styled-components';

const Distribution = styled.div`
display: flex;
justify-content: space-between;
align-items: center;
margin-top: 10px;
`;
const Button = styled.button`
text-transform: uppercase;
font-size: 13px;
font-family: AdihausDIN,Helvetica,Arial,sans-serif;
font-weight: 700;
letter-spacing: 2px;
background-color: transparent;
color: #000;
line-height: 17px;
min-height: 0;
padding: 2px 2px 3px;
text-align: left;
text-decoration: underline;
white-space: unset;
align-items: center;
border-radius: 0;
cursor: pointer;
display: inline-flex;
justify-content: flex-start;
position: relative;
transition: transform .1s cubic-bezier(.3,0,.45,1),color .1s cubic-bezier(.3,0,.45,1),border .1s cubic-bezier(.3,0,.45,1),background .1s cubic-bezier(.3,0,.45,1);
width: auto;
margin: 0;
background: none;
border: none;
box-shadow: none;
outline: none;
&:hover {
background-color: #000;
color: #fff;
text-decoration: underline;
}
&:active {
transform: scale(.97);
}
&:focus {
  outline: none;
}
`;
const Bar = styled.div`
box-sizing: border-box;
flex-grow: 1;
margin: 0 10px;
background-color: #767677;
border-radius: 2px;
font-size: 16px;
height: 4px;
-webkit-font-smoothing: antialiased;
`;
const Fill = styled(Bar)`
margin: 0;
width: ${props => `${props.width}%`};
background-color: #2ada71
`;

const Amount = styled.div`
text-transform: uppercase;
    font-family: AdihausDIN,Helvetica,Arial,sans-serif;
    font-weight: 400;
    letter-spacing: 2px;
    font-size: 11px;
    line-height: 15px;
`;

class ReviewListEntry extends React.Component {
  constructor(props) {
    super(props);
    this.state = {

    };
  }

  render() {
    let {star, percent, count} = this.props;
    return (
      <Distribution>
        <Button>{star} Stars</Button>
        <Bar><Fill width={percent}></Fill></Bar>
        <Amount>{count}</Amount>
      </Distribution>
    );
  }
}

export default ReviewListEntry;
