import React from 'react';
import { render } from '@testing-library/react';
import { About } from '../src/client/pages/About';

describe('About', () => {
    it('Should render author name', () => {
        const { container } = render(<About />);
1
        expect(container.textContent).toBe('AboutAuthor: Anuar');
    });
});
