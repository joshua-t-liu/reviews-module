/**
 * @jest-environment jsdom
 */
import React from 'react';
import { shallow, mount } from 'enzyme';

import ReviewList from '../client/src/components/ReviewList.jsx';
import ReviewListEntry from '../client/src/components/ReviewListEntry.jsx';
import sampleReviews from './sampleData';

test('should render 2 ReviewListEntry components', () => {
  const wrapper = shallow(
    <ReviewList
      reviews={sampleReviews}
    />
  );
  expect(wrapper.find(ReviewListEntry)).toHaveLength(2);
});
