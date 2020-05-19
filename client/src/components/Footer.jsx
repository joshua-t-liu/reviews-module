import React from 'react';
import styled from 'styled-components';

const FooterContent = styled.div`
    color: hsla(0,0%,100%,.6);
    background-color: #363738;
    margin: 100px 0px 0 0px;
    /* width: 1010px; */

`;

const Inner = styled.div`
    display: flex;
    align-items: flex-start;
    flex-wrap: wrap;
    justify-content: space-between;
  margin: 0 49px;
`;


const CountrySelector = styled.div`
float: left;
    width: 210px;
    padding: 21px 0 12px 10px;
    line-height: 12px;
    display: flex;
    justify-content: center;
`;

const Anchor = styled.a`
    display: flex;
    color: #c8cbcc;
    font-size: 12px;
    padding-left: 20px;
    cursor: pointer;
    text-decoration: none;
    border-radius: 0;
    box-shadow: none;
    outline: none;
    -webkit-tap-highlight-color: rgba(0,0,0,0);
`;

const CountryImage = styled.img`
    width: 15px;
    height: 11px;
    margin-right: 8px;
`;

const Links = styled.div`
display: flex;
justify-content: flex-end;
flex-direction: row;
flex-wrap: nowrap;
`;

const List = styled.ol`
    padding: 13px 0 12px;
    margin: 0;
    text-align: right;
list-style: none;
margin-block-start: 0.5em;
    margin-block-end: 0.5em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
    display: flex;
justify-content: flex-end;
flex-direction: row;
flex-wrap: nowrap;
`;

const ListItem = styled.li`
    margin: 0;
    display: inline;
    padding: 0;
    color: #c8cbcc;
`;

const Span = styled.span`
padding-right: 21px;
position: relative;
    margin: 0 8px;
    padding: 0;
    display: inline;
`;




const Footer = (props) => (
  <FooterContent>
    <Inner>
      <CountrySelector>
        <Anchor>
          <CountryImage src="https://adl-foundation.adidas.com/prod/v31.0.0/assets/flags/us.svg" alt="us flag" title="us flag" aria-label="us flag" />
          <span>USA</span>
        </Anchor>
      </CountrySelector>
      <Links>
        <List>
          <ListItem>
            <Anchor>
              Privacy Policy
            </Anchor>
          </ListItem>
          <ListItem>
            <Span >|</Span>
          </ListItem>
          <ListItem>
            <Anchor>
              Terms and Conditions
            </Anchor>
          </ListItem>
          <ListItem>
            <Span >|</Span>
          </ListItem>
          <ListItem>
            <Anchor>© 2020 Shoe Webstore Inc.</Anchor>
          </ListItem>
        </List>
      </Links>
    </Inner>
  </FooterContent>
);

export default Footer;