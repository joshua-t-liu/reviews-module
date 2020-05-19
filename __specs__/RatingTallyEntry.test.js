/**
 * @jest-environment jsdom
 */
import React from 'react';
import { shallow, mount } from 'enzyme';

import RatingTallyEntry from '../client/src/components/RatingTallyEntry.jsx';
import sampleReviews from './sampleData';

const sampleData = sampleReviews[0];

describe('Render Tests', () => {
  test('should render the correct number of ratings', () => {

  });
});

describe('filterByStar', () => {
  test('should invoke the filterByStar prop when the bar is clicked', () => {

  });
  test('should invoke the filterByStar prop with the correct arguments when the bar is clicked', () => {

  });
});

// describe('updateTodo', () => {
//   test('should invoke the updateTodo prop when the edit button is clicked', () => {
//     const mockUpdateTodo = jest.fn();
//     const wrapper = shallow(
//       <TodoListItem
//         todo={sampleData}
//         updateTodo={mockUpdateTodo}
//         deleteTodo={() => { }}
//       />
//     );
//     const updateButton = wrapper.find('i').first();
//     updateButton.simulate('click');
//     expect(mockUpdateTodo).toHaveBeenCalled();
//   });

//   test('should invoke the updateTodo prop with the correct arguments when the edit button is clicked', () => {
//     const mockUpdateTodo = jest.fn();
//     const wrapper = shallow(
//       <TodoListItem
//         todo={sampleData}
//         updateTodo={() => mockUpdateTodo(sampleData)}
//         deleteTodo={() => { }}
//       />
//     );

//     const updateButton = wrapper.find('i').first();
//     updateButton.simulate('click');
//     expect(mockUpdateTodo).toHaveBeenCalledWith(sampleData);
//   });
// });

// describe('deleteTodo', () => {
//   test('should invoke the updateTodo prop when the edit button is clicked', () => {
//     const mockDeleteTodo = jest.fn();
//     const wrapper = shallow(
//       <TodoListItem
//         todo={sampleData}
//         updateTodo={() => { }}
//         deleteTodo={mockDeleteTodo}
//       />
//     );
//     const deleteButton = wrapper.find('i').last();
//     deleteButton.simulate('click');
//     expect(mockDeleteTodo).toHaveBeenCalled();
//   });

//   test('should invoke the updateTodo prop with the correct arguments when the edit button is clicked', () => {
//     const mockDeleteTodo = jest.fn();
//     const wrapper = shallow(
//       <TodoListItem
//         todo={sampleData}
//         updateTodo={() => { }}
//         deleteTodo={() => mockDeleteTodo(sampleData._id)}
//       />
//     );

//     const deleteButton = wrapper.find('i').last();
//     deleteButton.simulate('click');
//     expect(mockDeleteTodo).toHaveBeenCalledWith(sampleData._id);
//   });
// });
