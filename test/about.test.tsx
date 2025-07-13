import { render } from '@testing-library/react';
import { About } from '../src/client/pages/About';
import React from 'react';

describe('About', () => {
  it('Should render author name', () => {
    const { container } = render(<About />);

    expect(container.textContent).toBe('AboutAuthor: Anasteisha');
  });
});
