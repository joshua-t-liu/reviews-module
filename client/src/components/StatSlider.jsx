import React, { Fragment } from 'react';
import styled from 'styled-components';

const Bar = styled.div`
margin-top: 20px;
`;
const Triangle = styled.div`
position: relative;
`;
const Title = styled.div`
    text-transform: uppercase;
    font-size: 13px;
    letter-spacing: 2px;
    margin-bottom: 7px;
    text-align: left;
    font-family: AdihausDIN,Helvetica,Arial,sans-serif;
    font-weight: 400;
`;
const Background = styled.div`
    overflow: visible;
    background-color: #767677;
    height: 4px;
    position: relative;
`;
const Arrow = styled.div`
    left: ${props => `${props.pct}%`};
border-top-color: #2ada71;
background-color: transparent;
    height: auto;
    top: -8px;
    width: 0;
    border-color: #2ada71 transparent transparent;
    border-style: solid;
    border-width: 20px 10px;
    position: absolute;
    z-index: 3;
`;
const Steps = styled.div`
    display: flex;
    height: 100%;
    justify-content: space-between;
    width: 100%;
`;
const Step = styled.div`
    left: ${props => `${props.pct}%`};
    margin-left: -2px;
    background-color: #fff;
    height: 4px;
    position: absolute;
    top: 0;
    width: 4px;
    z-index: 2;
    `;

const Labels = styled.div`
margin-top: 10px;
color: #000;
    display: flex;
    font-size: 12px;
    justify-content: space-between;
    letter-spacing: 2px;
    text-transform: uppercase;
`;
const Label = styled.span`
    text-transform: uppercase;
    font-family: AdihausDIN,Helvetica,Arial,sans-serif;
    font-weight: 400;
    letter-spacing: 2px;
    text-align: left;
    font-size: 11px;
    line-height: 15px;
`;



class StatSlider extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    let {title, labels, prct} = this.props;
    return (
      <Bar>
        <Triangle>
          <Title>{title}</Title>
          <Background>
            <Arrow pct={prct}></Arrow>
            <Steps>
              <Step pct={25}></Step>
              <Step pct={50}></Step>
              <Step pct={75}></Step>
            </Steps>
          </Background>
          <Labels>
            <Label>{labels[0]}</Label>
            <Label>{labels[1]}</Label>
            <Label>{labels[2]}</Label>
          </Labels> 
        </Triangle>
      </Bar>
    );
  }
}

export default StatSlider;