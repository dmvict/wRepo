( function _Base_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../../node_modules/Tools' );

  _.include( 'wCopyable' );
  _.include( 'wRepoBasic' );

  module.exports = _;
}

})();
