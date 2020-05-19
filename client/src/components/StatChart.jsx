import React, { Fragment } from 'react';
import styled from 'styled-components';
import StatSlider from './StatSlider.jsx';

const Header = styled.div`
margin: 20px 0 0 0;
`;
const Percent = styled.header`
margin:0;
padding:0;
font-size: 56px;
    line-height: 48px;
    font-family: AdineuePRO,Helvetica,Arial,sans-serif;
    font-style: normal;
    font-weight: 600;
`;


class StatChart extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return (
      <Fragment>
        <Header>
          <Percent>97%</Percent>
          <span>of customers recommend this product</span>
        </Header>
        <StatSlider title={'size'} labels={['small', 'perfect', 'large']} prct={50}/>
        <StatSlider title={'width'} labels={['narrow', 'perfect', 'wide']} prct={46}/>
        <StatSlider title={'comfort'} labels={['poor', '', 'perfect']} prct={85}/>
        <StatSlider title={'quality'} labels={['poor', '', 'perfect']} prct={90}/>
      </Fragment>
    );
  }
}

export default StatChart;