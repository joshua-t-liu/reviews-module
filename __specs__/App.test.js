/**
 * @jest-environment jsdom
 */
import React from 'react';
import { shallow, mount } from 'enzyme';
// import axios from 'axios';

import App from '../client/src/components/App.jsx';
import sampleData from './sampleData';
const sampleReviews = sampleData;

describe('Unit Tests', () => {
  it('should render the app component on the screen', () => {
    const wrapper = mount(<App/>);
    expect(wrapper.exists()).toBe(true);
  });
  // it('should render the app component on the screen', () => {
  //   const wrapper = mount(<App />);
  //   expect(wrapper.exists()).toBe(true);
  // });
});



// describe('Unit Tests', () => {
//   jest.mock('axios', () => {
//     const reviews = [
//       {
//         'id': 1,
//         'title': 'unit test',
//         'text': 'first sample',
//         'rating': '5/5',
//       },
//       {
//         'id': 2,
//         'title': 'unit test',
//         'text': 'second sample',
//         'rating': '5/5',
//       }
//     ];
//     return {
//       get: jest.fn(() => Promise.resolve(reviews)),
//     };
//   });

//   it('should render the app component on the screen', () => {
//     const wrapper = shallow(<App/>);
//     expect(wrapper.exists()).toBe(true);
//   });
//   test('should invoke fetchReviews on componentDidMount', () => {
//     const wrapper = shallow(<App />);
//     const mock = jest.fn();
//     wrapper.instance().fetchReviews = mock;
//     wrapper.instance().forceUpdate();
//     wrapper
//       .instance()
//       .componentDidMount();
//     expect(mock).toHaveBeenCalled();
//   });
// });
