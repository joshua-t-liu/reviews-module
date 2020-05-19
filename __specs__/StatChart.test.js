/**
 * @jest-environment jsdom
 */
import React from 'react';
import { shallow, mount } from 'enzyme';

import StatChart from '../client/src/components/StatChart.jsx';
import StatSlider from '../client/src/components/StatSlider.jsx';
import sampleData from './sampleData';

test('should render 4 StatSlider components', () => {
  const wrapper = shallow(
    <StatChart
      rating={sampleData}
    />
  );
  expect(wrapper.find(StatSlider)).toHaveLength(4);
});
