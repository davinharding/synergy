import ReactOnRails from 'react-on-rails';

import TestComponent from '../bundles/TestComponent/components/TestComponent';

// This is how react_on_rails can see the TestComponent in the browser.
ReactOnRails.register({
  TestComponent,
});
