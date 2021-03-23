/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import FeedbackForm from '../../components/FeedbackForm';

describe('<FeedbackForm />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<FeedbackForm />);

    assert.strictEqual(wrapper.find('Form').length, 1);
    assert.strictEqual(wrapper.find('FormGroup').length, 2);
    assert.strictEqual(wrapper.find('FormGroup').at(0).find('Label').length, 1);
    assert.strictEqual(wrapper.find('FormGroup').at(0).find('Input').length, 1);
    assert.strictEqual(wrapper.find('FormGroup').at(0).find('Input').prop('placeholder'), 'Name');
    assert.strictEqual(wrapper.find('FormGroup').at(1).find('Input').prop('placeholder'), 'Comments');
  });
});
