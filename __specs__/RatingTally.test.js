/**
 * @jest-environment jsdom
 */
import React from 'react';
import { shallow, mount } from 'enzyme';

import RatingTally from '../client/src/components/RatingTally.jsx';
import RatingTallyEntry from '../client/src/components/RatingTallyEntry.jsx';
import sampleReviews from './sampleData';

test('should render 5 RatingTallyEntry components', () => {
  const wrapper = shallow(
    <RatingTally
      reviews={sampleReviews}
    />
  );
  expect(wrapper.find(RatingTallyEntry)).toHaveLength(5);
});
