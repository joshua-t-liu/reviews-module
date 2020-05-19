/**
 * @jest-environment jsdom
 */
import React from 'react';
import { shallow, mount } from 'enzyme';

import StatSlider from '../client/src/components/StatSlider.jsx';
import sampleReviews from './sampleData';

const sampleData = {
  type: 'size',
  average: 3.5
};

describe('Render Tests', () => {
  test('should render the correct category string', () => {
    const wrapper = shallow(
      <StatSlider
        rating={sampleData}
      />
    );
    expect(wrapper.find('.text')).toHaveLength(1);
    expect(wrapper.find('.text').text()).toBe('size');
  });
});

