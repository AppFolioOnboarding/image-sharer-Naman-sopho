/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import Footer from '../../components/Footer';

describe('<Footer />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<Footer text="footer text" />);
    const footer = wrapper.find('footer');

    assert.strictEqual(footer.length, 1);
    assert.strictEqual(footer.text(), 'footer text');
  });
});
