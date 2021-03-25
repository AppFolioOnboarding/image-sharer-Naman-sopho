/* eslint-env mocha */

import assert from 'assert';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import React from 'react';
import FeedbackForm from '../../components/FeedbackForm';
import * as utilHelper from '../../utils/helper';

describe('<FeedbackForm />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<FeedbackForm />);

    assert.strictEqual(wrapper.find('Form').length, 1);
    assert.strictEqual(wrapper.find('FormGroup').length, 2);
    assert.strictEqual(wrapper.find('FormGroup').at(0).find('Label').length, 1);
    assert.strictEqual(wrapper.find('FormGroup').at(0).find('Input').length, 1);
    assert.strictEqual(wrapper.find('FormGroup').at(0).find('Input').prop('placeholder'), 'Name');
    assert.strictEqual(wrapper.find('FormGroup').at(1).find('Input')
      .prop('placeholder'), 'Comments');
    assert.strictEqual(wrapper.find('Button').length, 1);
  });

  describe('submit <FeedbackForm />', () => {
    afterEach(() => {
      sinon.restore();
    });
    it('should submit form correctly', () => {
      const wrapper = shallow(<FeedbackForm />);

      const postStub = sinon.stub(utilHelper, 'post').resolves();
      wrapper.instance().state.name = 'Test';
      wrapper.instance().state.comment = 'Test Comment';

      return wrapper.instance().submitForm().then(() => {
        assert(postStub.calledOnceWithExactly(
          '/api/feedbacks',
          { name: 'Test', comment: 'Test Comment' }
        ));
        assert.strictEqual(wrapper.state('alert'), 'Successfully Submitted');

        wrapper.update();
        assert.strictEqual(wrapper.find('FormGroup').at(0).find('Input').prop('value'), '');
        assert.strictEqual(wrapper.find('FormGroup').at(1).find('Input').prop('value'), '');
        assert.strictEqual(wrapper.find('h6').text(), 'Successfully Submitted');
      });
    });

    it('should not submit form', () => {
      const wrapper = shallow(<FeedbackForm />);

      const postStub = sinon.stub(utilHelper, 'post').rejects();
      wrapper.instance().state.name = 'Test';
      wrapper.instance().state.comment = '';

      return wrapper.instance().submitForm().then(() => {
        assert(postStub.calledOnceWithExactly('/api/feedbacks', { name: 'Test', comment: '' }));
        assert.strictEqual(wrapper.state('alert'), 'Could not submit feedback');

        wrapper.update();
        assert.strictEqual(wrapper.find('FormGroup').at(0).find('Input').prop('value'), '');
        assert.strictEqual(wrapper.find('FormGroup').at(1).find('Input').prop('value'), '');
        assert.strictEqual(wrapper.find('h6').text(), 'Could not submit feedback');
      });
    });

    it('should update name in the state correctly', () => {
      const wrapper = shallow(<FeedbackForm />);

      wrapper.find('FormGroup').at(0).find('Input')
        .simulate('change', { target: { value: 'Test' } });

      assert.strictEqual(wrapper.instance().state.name, 'Test');
    });

    it('should update comment in the state correctly', () => {
      const wrapper = shallow(<FeedbackForm />);

      wrapper.find('FormGroup').at(1).find('Input')
        .simulate('change', { target: { value: 'Test Comment' } });

      assert.strictEqual(wrapper.instance().state.comment, 'Test Comment');
    });
  });
});
