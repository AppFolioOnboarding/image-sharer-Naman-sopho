import PropTypes from 'prop-types';
import React from 'react';

export default function Footer(props) {
  return (
    <footer>
      <h6 className='text-center'>{props.text}</h6>
    </footer>
  );
}

Footer.propTypes = {
  text: PropTypes.string.isRequired
};
