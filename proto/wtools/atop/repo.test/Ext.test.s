( function _Ext_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../node_modules/Tools' );
  require( '../repo/entry/Include.s' );
  _.include( 'wTesting' );
}

const _ = _global_.wTools;
const __ = _globals_.testing.wTools;

// --
// context
// --

function onSuiteBegin()
{
  let context = this;
  context.suiteTempPath = __.path.tempOpen( __.path.join( __dirname, '../..' ), 'repo' );
  context.appJsPath = __.path.join( __dirname, '../repo/entry/Exec' );
}

//

function onSuiteEnd()
{
  let context = this;
  __.assert( __.strHas( context.suiteTempPath, '/repo' ) )
  __.path.tempClose( context.suiteTempPath );
}

// --
// tests
// --

function agree( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';

  /* - */

  begin();
  a.ready.then( () =>
  {
    test.case = 'agree with local repository, use master branch to agree with';
    return null;
  });
  a.appStart( '.agree dst:./!master src:../repo!master' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    return null;
  });
  a.shell( 'git log -n 1' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /Merge branch \'master\' of .*\/repo into master/ ), 1 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'agree with local repository, use commit to agree with';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git log -n 1' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /Merge branch \'master\' of .*\/repo.* into master/ ), 1 );
    return null;
  });

  /* - */

  begin();
  a.ready.then( () =>
  {
    test.case = 'agree with remote repository, use master branch to agree with';
    return null;
  });
  a.appStart( `.agree dst:./!master src:'${ srcRepositoryRemote }'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    return null;
  });
  a.shell( 'git log -n 1' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    console.log( op.output );
    test.identical( _.strCount( op.output, /Merge branch \'master\' of https.*\/wModuleForTesting2.* into master/ ), 1 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'agree with local repository, use commit to agree with';
    return null;
  });
  a.appStart( `.agree dst:./!master src:\`${ srcRepositoryRemote }#${ srcState }\`` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git log -n 1' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, /Merge branch \'master\' of https.*\/wModuleForTesting2.* into master/ ), 1 );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

//

function agreeWithOptionMessage( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';

  /* - */

  begin();
  a.ready.then( () =>
  {
    test.case = 'agree with local repository, use commit to agree with';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } message:'Sync repositories'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git log -n 1' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, 'Sync repositories' ), 1 );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

//

function agreeWithOptionBut( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';

  /* - */

  begin();
  a.ready.then( () =>
  {
    test.case = 'no option but';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 14 );
    test.true( _.longHasAll( files, [ 'will.yml', 'package.json', 'was.package.json' ] ) );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'but - string, matches file, exclude single file';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } but:'package.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 13 );
    test.true( _.longHasAll( files, [ 'will.yml', 'was.package.json' ] ) );
    test.false( _.longHas( files, 'package.json' ) );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'but - string, no matching, exclude no file';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } but:'unknown.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 14 );
    test.true( _.longHasAll( files, [ 'will.yml', 'package.json', 'was.package.json' ] ) );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'but - string with glob, matches files, exclude two files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } but:'*package.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 12 );
    test.true( _.longHas( files, 'will.yml' ) );
    test.false( _.longHasAny( files, [ 'package.json', 'was.package.json' ] ) );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'but - several strings in array, matches files, exclude two files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } but:'*package.json' but:'will.yml' but:'unknown.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 11 );
    test.false( _.longHasAny( files, [ 'will.yml', 'package.json', 'was.package.json' ] ) );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'but - several strings in array, matches files, exclude two files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } but:'[*package.json, will.yml, unknown.json]'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 11 );
    test.false( _.longHasAny( files, [ 'will.yml', 'package.json', 'was.package.json' ] ) );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

agreeWithOptionBut.timeOut = 180000;

//

function agreeWithOptionOnly( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';

  /* - */

  begin();
  a.ready.then( () =>
  {
    test.case = 'no option only';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 14 );
    test.true( _.longHasAll( files, [ 'will.yml', 'package.json', 'was.package.json' ] ) );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'only - string, matches file, include single file';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } only:'package.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 1 );
    test.identical( files, [ 'package.json' ] );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'only - string, no matching, include no file';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } only:'unknown.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'only - string with glob, matches files, include two files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } only:'*package.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 2 );
    test.identical( files, [ 'package.json', 'was.package.json' ] );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'only - several strings in array, matches files, exclude two files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } only:'*package.json' only:'will.yml' only:'unknown.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 3 );
    test.identical( files, [ 'package.json', 'was.package.json', 'will.yml' ] );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'only - several strings in array, matches files, exclude two files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } only:'[*package.json, will.yml, unknown.json]'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 3 );
    test.identical( files, [ 'package.json', 'was.package.json', 'will.yml' ] );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

agreeWithOptionOnly.timeOut = 180000;

//

function agreeWithOptionSrcDirPath( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';

  /* - */

  let filesBefore;
  begin().then( () =>
  {
    test.case = 'srcDirPath - current dir, dot, no only';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } srcDirPath:'.' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    let files = op.output.trim().split( '\n' );
    test.identical( files.length, 14 );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'srcDirPath - current dir, dot with slash, no only';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } srcDirPath:'./' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    let files = op.output.trim().split( '\n' );
    test.identical( files.length, 14 );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'srcDirPath - nested dir, no only';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } srcDirPath:'./proto' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    var exp = [ 'proto/node_modules/wmodulefortesting2', 'proto/wtools/testing/l2/testing2/ModuleForTesting2.s' ];
    test.identical( files, exp );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting1' );
    test.identical( config.version, '0.0.186' );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* - */

  begin().then( () =>
  {
    test.case = 'srcDirPath - current dir, dot, with only';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } srcDirPath:'.' only:'**/*.s' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    var exp = [ 'proto/wtools/testing/l2/testing2/ModuleForTesting2.s', 'sample/trivial/Sample.s' ];
    test.identical( files, exp );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* */

  begin().then( () =>
  {
    filesBefore = a.find( a.abs( './' ) );
    test.case = 'srcDirPath - current dir, dot and slash, with only';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } srcDirPath:'./' only:'**/*.s' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    var exp = [ 'proto/wtools/testing/l2/testing2/ModuleForTesting2.s', 'sample/trivial/Sample.s' ];
    test.identical( files, exp );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'srcDirPath - nested dir, with only';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } srcDirPath:'proto' only:'**/*.s' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    var exp = [ 'proto/wtools/testing/l2/testing2/ModuleForTesting2.s' ];
    test.identical( files, exp );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

//

function agreeWithOptionDstDirPath( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';

  /* - */

  let filesBefore;
  begin().then( () =>
  {
    test.case = 'dstDirPath - current dir';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } dstDirPath:'.' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 14 );
    test.identical( _.path.common( files ), '.' );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'dstDirPath - nested existed dir';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } dstDirPath:'proto' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 19 );
    test.identical( _.path.common( files ), 'proto/' );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'dstDirPath - nested not existed dir';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } dstDirPath:'dev' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 19 );
    test.identical( _.path.common( files ), 'dev/' );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* - */

  begin().then( () =>
  {
    test.case = 'dstDirPath - nested existed dir, with srcDirPath';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } dstDirPath:'proto' srcDirPath:'proto' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    var exp =
    [
      'proto/proto/node_modules/wmodulefortesting2',
      'proto/proto/wtools/testing/Common.s',
      'proto/proto/wtools/testing/l2/testing2/ModuleForTesting2.s',
    ];
    test.identical( files, exp );
    test.identical( _.path.common( files ), 'proto/proto/' );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'dstDirPath - nested existed dir, with only';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } dstDirPath:'proto' only:'proto/**' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    var exp =
    [
      'proto/proto/node_modules/wmodulefortesting2',
      'proto/proto/wtools/testing/Common.s',
      'proto/proto/wtools/testing/l2/testing2/ModuleForTesting2.s',
    ];
    test.identical( files, exp );
    test.identical( _.path.common( files ), 'proto/proto/' );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'dstDirPath - nested not existed dir, with srcDirPath';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } dstDirPath:'dev' srcDirPath:'proto' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    var exp =
    [
      'dev/proto/node_modules/wmodulefortesting2',
      'dev/proto/wtools/testing/Common.s',
      'dev/proto/wtools/testing/l2/testing2/ModuleForTesting2.s',
    ];
    test.identical( files, exp );
    test.identical( _.path.common( files ), 'dev/proto/' );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'dstDirPath - nested not existed dir, with only';
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState } dstDirPath:'dev' only:'proto/**' message:__sync__` );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    var exp =
    [
      'dev/proto/node_modules/wmodulefortesting2',
      'dev/proto/wtools/testing/Common.s',
      'dev/proto/wtools/testing/l2/testing2/ModuleForTesting2.s',
    ];
    test.identical( files, exp );
    test.identical( _.path.common( files ), 'dev/proto/' );

    var filesAfter = a.find( a.abs( './' ) );
    test.notIdentical( filesBefore, filesAfter );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

//

function migrate( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState1 = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';
  const srcState2 = 'd8c18d24c1d65fab1af6b8d676bba578b58bfad5';

  /* - */

  begin();
  a.ready.then( () =>
  {
    test.case = 'migrate with local repository, start commit';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'migrate with local repository, start and end commits';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });

  /* - */

  begin();
  a.ready.then( () =>
  {
    test.case = 'migrate with remote repository, start commit';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:'${ srcRepositoryRemote }!master' srcState1:#${ srcState1 }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'migrate with local repository, start and end commits';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart
  (
    `.migrate dst:./!master src:'${ srcRepositoryRemote }!master' srcState1:#${ srcState1 } srcState2:#${ srcState2 }`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

//

function migrateWithOptionOnMessage( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState1 = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';
  const srcState2 = 'd8c18d24c1d65fab1af6b8d676bba578b58bfad5';

  /* - */

  begin();
  a.ready.then( () =>
  {
    test.case = 'no option onMessage';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 0 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'absolute path, onMessage returns static message, should write each commit with message';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ a.abs( '../OnMessage.js' ) }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 15 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'relative path, onMessage returns static message, should write each commit with message';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 15 );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    let code =
`
  function onMessage( msg )
  {
    return '__sync__';
  }
  module.exports = onMessage;
`;
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../OnMessage.js' ) ); return null });
    a.ready.then( () => { a.fileProvider.fileWrite( a.abs( '../OnMessage.js' ), code ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

//

function migrateWithOptionBut( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState1 = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';
  const srcState2 = 'd8c18d24c1d65fab1af6b8d676bba578b58bfad5';

  /* - */

  begin();
  a.ready.then( () =>
  {
    test.case = 'no option but';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ a.abs( '../OnMessage.js' ) }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 15 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'but - string, matches file, exclude single file';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' } but:'package.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 15 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'but - string, matches no file, exclude no file';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' } but:'unknown.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 15 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'but - string with glob, matches file, exclude two files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' } but:'*package.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 9 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'but - array of strings, matches files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' } but:'*package.json' but:'will.yml' but:'unknown.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 7 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'but - array of strings, matches files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' } but:[*package.json, will.yml, unknown.json]` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 7 );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    let code =
`
  function onMessage( msg )
  {
    return '__sync__';
  }
  module.exports = onMessage;
`;
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../OnMessage.js' ) ); return null });
    a.ready.then( () => { a.fileProvider.fileWrite( a.abs( '../OnMessage.js' ), code ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

migrateWithOptionBut.timeOut = 180000;

//

function migrateWithOptionOnly( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState1 = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';
  const srcState2 = 'd8c18d24c1d65fab1af6b8d676bba578b58bfad5';

  /* - */

  begin();
  a.ready.then( () =>
  {
    test.case = 'no option only';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ a.abs( '../OnMessage.js' ) }` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 15 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'only - string, matches file, include single file';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' } only:'package.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 8 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'only - string, matches no file, include no file';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' } only:'unknown.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 0 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'only - string with glob, matches file, include two files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' } only:'*package.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 8 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'only - array of strings, matches files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' } only:'*package.json' only:'will.yml' only:'unknown.json'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 10 );
    return null;
  });

  /* */

  begin();
  a.ready.then( () =>
  {
    test.case = 'only - array of strings, matches files';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );

  a.appStart( `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } onMessage:${ '../OnMessage.js' } only:'[*package.json, will.yml, unknown.json]'` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 10 );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    let code =
`
  function onMessage( msg )
  {
    return '__sync__';
  }
  module.exports = onMessage;
`;
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../OnMessage.js' ) ); return null });
    a.ready.then( () => { a.fileProvider.fileWrite( a.abs( '../OnMessage.js' ), code ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

migrateWithOptionOnly.timeOut = 180000;

//

function migrateWithOptionSrcDirPath( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState1 = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';
  const srcState2 = 'd8c18d24c1d65fab1af6b8d676bba578b58bfad5';
  const user = a.shell({ currentPath : __dirname, execPath : 'git config --global user.name', sync : 1 }).output.trim();

  /* - */

  let filesBefore;
  begin().then( () =>
  {
    test.case = 'srcDirPath - current dir, dot, without only';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );
  a.ready.then( () =>
  {
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart
  (
    `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } `
    + `srcDirPath:'.' onMessage:${ a.abs( '../OnMessage.js' ) }`
  );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 3 );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'will.yml' ) );
    test.identical( config.about.name, 'wModuleForTesting2' );
    test.identical( config.about.version, '0.1.0' );

    var filesAfter = a.find( a.abs( './' ) );
    test.identical( filesBefore, filesAfter );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 15 );
    test.ge( _.strCount( op.output, `Author: ${ user }` ), 15 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'srcDirPath - current dir, dot and slash, without only';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );
  a.ready.then( () =>
  {
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart
  (
    `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } `
    + `srcDirPath:'./' onMessage:${ a.abs( '../OnMessage.js' ) }`
  );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 3 );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'will.yml' ) );
    test.identical( config.about.name, 'wModuleForTesting2' );
    test.identical( config.about.version, '0.1.0' );

    var filesAfter = a.find( a.abs( './' ) );
    test.identical( filesBefore, filesAfter );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 15 );
    test.ge( _.strCount( op.output, `Author: ${ user }` ), 15 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'srcDirPath - nested dir, without only';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );
  a.ready.then( () =>
  {
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart
  (
    `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } `
    + `srcDirPath:'./proto' onMessage:${ a.abs( '../OnMessage.js' ) }`
  );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 14 );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'will.yml' ) );
    test.identical( config.about.name, 'wModuleForTesting2' );
    test.identical( config.about.version, '0.1.0' );

    var filesAfter = a.find( a.abs( './' ) );
    test.identical( filesBefore, filesAfter );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 0 );
    test.ge( _.strCount( op.output, `Author: ${ user }` ), 0 );
    return null;
  });

  /* - */

  begin().then( () =>
  {
    test.case = 'srcDirPath - current dir, dot, with only';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );
  a.ready.then( () =>
  {
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart
  (
    `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } `
    + `srcDirPath:'.' only:'[*package*, **.s]' onMessage:${ a.abs( '../OnMessage.js' ) }`
  );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 2 );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'will.yml' ) );
    test.identical( config.about.name, 'wModuleForTesting2' );
    test.identical( config.about.version, '0.1.0' );

    var filesAfter = a.find( a.abs( './' ) );
    test.identical( filesBefore, filesAfter );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 8 );
    test.ge( _.strCount( op.output, `Author: ${ user }` ), 8 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'srcDirPath - current dir, dot and slash, with only';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );
  a.ready.then( () =>
  {
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart
  (
    `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } `
    + `srcDirPath:'./' only:'[*package*, **.s]' onMessage:${ a.abs( '../OnMessage.js' ) }`
  );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 2 );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'will.yml' ) );
    test.identical( config.about.name, 'wModuleForTesting2' );
    test.identical( config.about.version, '0.1.0' );

    var filesAfter = a.find( a.abs( './' ) );
    test.identical( filesBefore, filesAfter );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 8 );
    test.ge( _.strCount( op.output, `Author: ${ user }` ), 8 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'srcDirPath - nested dir, with only';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );
  a.ready.then( () =>
  {
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart
  (
    `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } `
    + `srcDirPath:'proto' only:'[*package*, **.s]' onMessage:${ a.abs( '../OnMessage.js' ) }`
  );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 14 );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.170' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'will.yml' ) );
    test.identical( config.about.name, 'wModuleForTesting2' );
    test.identical( config.about.version, '0.1.0' );

    var filesAfter = a.find( a.abs( './' ) );
    test.identical( filesBefore, filesAfter );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 0 );
    test.ge( _.strCount( op.output, `Author: ${ user }` ), 0 );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    let code =
`
  function onMessage( msg )
  {
    return '__sync__';
  }
  module.exports = onMessage;
`;
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../OnMessage.js' ) ); return null });
    a.ready.then( () => { a.fileProvider.fileWrite( a.abs( '../OnMessage.js' ), code ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

migrateWithOptionSrcDirPath.timeOut = 180000;

//

function migrateWithOptionDstDirPath( test )
{
  const a = test.assetFor( false );
  const dstRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const dstCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting2.git';
  const srcState1 = 'f68a59ec46b14b1f19b1e3e660e924b9f1f674dd';
  const srcState2 = 'd8c18d24c1d65fab1af6b8d676bba578b58bfad5';
  const user = a.shell({ currentPath : __dirname, execPath : 'git config --global user.name', sync : 1 }).output.trim();

  /* - */

  let filesBefore;
  begin().then( () =>
  {
    test.case = 'dstDirPath - current dir';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 }` );
  a.ready.then( () =>
  {
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart
  (
    `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } `
    + `dstDirPath:'.' onMessage:${ a.abs( '../OnMessage.js' ) }`
  );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 3 );

    var config = a.fileProvider.fileReadUnknown( a.abs( 'package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'was.package.json' ) );
    test.identical( config.name, 'wmodulefortesting2' );
    test.identical( config.version, '0.0.178' );
    var config = a.fileProvider.fileReadUnknown( a.abs( 'will.yml' ) );
    test.identical( config.about.name, 'wModuleForTesting2' );
    test.identical( config.about.version, '0.1.0' );

    var filesAfter = a.find( a.abs( './' ) );
    test.identical( filesBefore, filesAfter );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 15 );
    test.ge( _.strCount( op.output, `Author: ${ user }` ), 15 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'dstDirPath - nested dir, dir synchronized';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 } dstDirPath:proto` );
  a.ready.then( () =>
  {
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart
  (
    `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } `
    + `dstDirPath:'proto' onMessage:${ a.abs( '../OnMessage.js' ) }`
  );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 3 );

    var filesAfter = a.find( a.abs( './' ) );
    test.identical( filesBefore, filesAfter );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 15 );
    test.ge( _.strCount( op.output, `Author: ${ user }` ), 15 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'dstDirPath - nested dir, srcDirPath, dir synchronized';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 } dstDirPath:proto` );
  a.ready.then( () =>
  {
    filesBefore = a.find( a.abs( './' ) );
    return null;
  });
  a.appStart
  (
    `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } `
    + `srcDirPath:proto dstDirPath:proto onMessage:${ a.abs( '../OnMessage.js' ) }`
  );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 19 );

    var filesAfter = a.find( a.abs( './' ) );
    test.identical( filesBefore, filesAfter );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 0 );
    test.ge( _.strCount( op.output, `Author: ${ user }` ), 0 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'dstDirPath - nested dir, srcDirPath, dir synchronized';
    return null;
  });
  a.appStart( `.agree dst:./!master src:../repo#${ srcState1 } dstDirPath:proto` );
  a.appStart
  (
    `.migrate dst:./!master src:../repo!master srcState1:#${ srcState1 } srcState2:#${ srcState2 } `
    + `dstDirPath:'proto' only:'[*package*, **.s]' onMessage:${ a.abs( '../OnMessage.js' ) }`
  );
  a.shell( 'git diff --name-only HEAD~..HEAD' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    var files = op.output.trim().split( '\n' );
    test.identical( files.length, 2 );

    var filesAfter = a.find( a.abs( './' ) );
    test.identical( filesBefore, filesAfter );
    return null;
  });
  a.shell( 'git log -n 20' );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    test.identical( _.strCount( op.output, '__sync__' ), 8 );
    test.ge( _.strCount( op.output, `Author: ${ user }` ), 8 );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    let code =
`
  function onMessage( msg )
  {
    return '__sync__';
  }
  module.exports = onMessage;
`;
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../OnMessage.js' ) ); return null });
    a.ready.then( () => { a.fileProvider.fileWrite( a.abs( '../OnMessage.js' ), code ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '../repo' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ dstRepositoryRemote } ./` );
    a.shell( `git reset --hard ${ dstCommit }` );
    return a.shell( `git clone ${ srcRepositoryRemote } ../repo` );
  }
}

migrateWithOptionDstDirPath.timeOut = 180000;

//

function commitsDates( test )
{
  const a = test.assetFor( false );
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const srcCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';

  /* */

  let originalHistory = [];
  begin().then( () =>
  {
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    originalHistory = op;
    return null
  });

  /* - */

  begin().then( () =>
  {
    test.case = 'relative - commit, change no date';
    return null;
  });
  a.appStart( `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' relative:commit delta:0` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.identical( op, originalHistory );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - commit, state2 is not last commit';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' `
    + `state2:'#af815d4eaaf1df0505da1e1b2e526a7d04cdce7e' relative:commit delta:0`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.identical( op, originalHistory );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - now, change date to current';
    return null;
  });
  a.appStart( `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' relative:now delta:0` );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.le( Date.parse( op[ 12 ].date ), Date.now() );
    test.ge( Date.parse( op[ 12 ].date ), Date.now() - 20000 );
    test.le( Date.parse( op[ 0 ].date ), Date.now() );
    test.ge( Date.parse( op[ 0 ].date ), Date.now() - 20000 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - now, state2 is not last commit';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' `
    + `state2:'#af815d4eaaf1df0505da1e1b2e526a7d04cdce7e' relative:now delta:0`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.le( Date.parse( op[ 12 ].date ), Date.now() );
    test.ge( Date.parse( op[ 12 ].date ), Date.now() - 20000 );
    test.le( Date.parse( op[ 0 ].date ), Date.parse( originalHistory[ 0 ].date ) );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ srcRepositoryRemote } ./` );
    return a.shell( `git reset --hard ${ srcCommit }` );
  }
}

//

function commitsDatesWithOptionDelta( test )
{
  const a = test.assetFor( false );
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const srcCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';

  /* */

  let originalHistory = [];
  begin().then( () =>
  {
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    originalHistory = op;
    return null
  });

  /* - */

  begin().then( () =>
  {
    test.case = 'relative - commit, state2 - to last commit, positive delta, one hour in miliseconds';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' relative:commit delta:3600000`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.identical( Date.parse( op[ 12 ].date ) - Date.parse( originalHistory[ 12 ].date ), 3600000 );
    test.identical( Date.parse( op[ 0 ].date ) - Date.parse( originalHistory[ 0 ].date ), 3600000 );
    return null;
  });

  /* */
  begin().then( () =>
  {
    test.case = 'relative - commit, state2 is not last commit, positive delta, one hour in miliseconds';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' `
    + `state2:'#af815d4eaaf1df0505da1e1b2e526a7d04cdce7e' relative:commit delta:3600000`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.identical( Date.parse( op[ 12 ].date ) - Date.parse( originalHistory[ 12 ].date ), 3600000 );
    test.identical( Date.parse( op[ 0 ].date ), Date.parse( originalHistory[ 0 ].date ) );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - now, state2 - to last commit, positive delta, one hour in miliseconds';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' relative:now delta:3600000`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.ge( Date.parse( op[ 12 ].date ) - Date.now(), 3500000 );
    test.le( Date.parse( op[ 12 ].date ) - Date.now(), 3600000 );
    test.ge( Date.parse( op[ 0 ].date ) - Date.now(), 3500000 );
    test.le( Date.parse( op[ 0 ].date ) - Date.now(), 3600000 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - now, state2 is not last commit, positive delta, one hour in miliseconds';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' `
    + `state2:'#af815d4eaaf1df0505da1e1b2e526a7d04cdce7e' relative:now delta:3600000`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.ge( Date.parse( op[ 12 ].date ) - Date.now(), 3500000 );
    test.le( Date.parse( op[ 12 ].date ) - Date.now(), 3600000 );
    test.ge( Date.parse( op[ 0 ].date ), Date.parse( originalHistory[ 0 ].date ) );
    return null;
  });

  /* - */

  begin().then( () =>
  {
    test.case = 'relative - commit, state2 - to last commit, negative delta, one hour in miliseconds';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' relative:commit delta:-3600000`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.identical( Date.parse( op[ 12 ].date ) - Date.parse( originalHistory[ 12 ].date ), -3600000 );
    test.identical( Date.parse( op[ 0 ].date ) - Date.parse( originalHistory[ 0 ].date ), -3600000 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - commit, state2 is not last commit, positive delta, one hour in miliseconds';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' `
    + `state2:'#af815d4eaaf1df0505da1e1b2e526a7d04cdce7e' relative:commit delta:-3600000`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.identical( Date.parse( op[ 12 ].date ) - Date.parse( originalHistory[ 12 ].date ), -3600000 );
    test.identical( Date.parse( op[ 0 ].date ), Date.parse( originalHistory[ 0 ].date ) );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - now, state2 - to last commit, negative delta, one hour in miliseconds';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' relative:now delta:-3600000`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.ge( Date.now() - Date.parse( op[ 12 ].date ), 3500000 );
    test.le( Date.now() - Date.parse( op[ 12 ].date ), 3700000 );
    test.ge( Date.now() - Date.parse( op[ 0 ].date ), 3500000 );
    test.le( Date.now() - Date.parse( op[ 0 ].date ), 3700000 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - now, state2 is not last commit, negative delta, one hour in miliseconds';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' `
    + `state2:'#af815d4eaaf1df0505da1e1b2e526a7d04cdce7e' relative:now delta:-3600000`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.ge( Date.now() - Date.parse( op[ 12 ].date ), 3500000 );
    test.le( Date.now() - Date.parse( op[ 12 ].date ), 3700000 );
    test.ge( Date.parse( op[ 0 ].date ), Date.parse( originalHistory[ 0 ].date ) );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ srcRepositoryRemote } ./` );
    return a.shell( `git reset --hard ${ srcCommit }` );
  }
}

commitsDatesWithOptionDelta.timeOut = 120000;

//

function commitsDatesWithOptionDeltaAsString( test )
{
  const a = test.assetFor( false );
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const srcCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';

  /* */

  let originalHistory = [];
  begin().then( () =>
  {
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    originalHistory = op;
    return null
  });

  /* - */

  begin().then( () =>
  {
    test.case = 'relative - commit, state2 - to last commit, positive delta, one hour';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' relative:commit delta:'01:00:00'`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.identical( Date.parse( op[ 12 ].date ) - Date.parse( originalHistory[ 12 ].date ), 3600000 );
    test.identical( Date.parse( op[ 0 ].date ) - Date.parse( originalHistory[ 0 ].date ), 3600000 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - commit, state2 - to last commit, negative delta, one hour';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' relative:commit delta:'-01:00:00'`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.identical( Date.parse( op[ 12 ].date ) - Date.parse( originalHistory[ 12 ].date ), -3600000 );
    test.identical( Date.parse( op[ 0 ].date ) - Date.parse( originalHistory[ 0 ].date ), -3600000 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - commit, state2 - to last commit, positive delta, two days';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' relative:commit delta:'48:00:00'`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.identical( Date.parse( op[ 12 ].date ) - Date.parse( originalHistory[ 12 ].date ), 86400000 * 2 );
    test.identical( Date.parse( op[ 0 ].date ) - Date.parse( originalHistory[ 0 ].date ), 86400000 * 2 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - commit, state2 - to last commit, negative delta, two days';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' relative:commit delta:'-48:00:00'`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.identical( Date.parse( op[ 12 ].date ) - Date.parse( originalHistory[ 12 ].date ), -86400000 * 2 );
    test.identical( Date.parse( op[ 0 ].date ) - Date.parse( originalHistory[ 0 ].date ), -86400000 * 2 );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ srcRepositoryRemote } ./` );
    return a.shell( `git reset --hard ${ srcCommit }` );
  }
}

//

function commitsDatesWithOptionPeriodic( test )
{
  const a = test.assetFor( false );
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const srcCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';

  /* */

  let originalHistory = [];
  begin().then( () =>
  {
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    originalHistory = op;
    return null
  });

  /* - */

  begin().then( () =>
  {
    test.case = 'relative - now, state2 - to last commit, positive delta, periodic - one hour';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' `
    + `relative:now delta:3600000 periodic:'01:00:00'`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );
    test.ge( Date.parse( op[ 11 ].date ) - _.time.now(), 3500000 );
    test.le( Date.parse( op[ 11 ].date ) - _.time.now(), 3600000 );

    test.identical( Date.parse( op[ 11 ].date ) - Date.parse( op[ 12 ].date ), 3600000 );
    test.identical( Date.parse( op[ 10 ].date ) - Date.parse( op[ 11 ].date ), 3600000 );
    test.identical( Date.parse( op[ 0 ].date ) - Date.parse( op[ 1 ].date ), 3600000 );
    return null;
  });

  /* */

  begin().then( () =>
  {
    test.case = 'relative - commit, state2 - to last commit, positive delta, periodic - one hour';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' `
    + `relative:commit delta:3600000 periodic:'01:00:00'`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );

    test.identical( Date.parse( op[ 11 ].date ) - Date.parse( op[ 12 ].date ), 3600000 );
    test.identical( Date.parse( op[ 10 ].date ) - Date.parse( op[ 11 ].date ), 3600000 );
    test.identical( Date.parse( op[ 0 ].date ) - Date.parse( op[ 1 ].date ), 3600000 );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ srcRepositoryRemote } ./` );
    return a.shell( `git reset --hard ${ srcCommit }` );
  }
}

//

function commitsDatesWithOptionDeviation( test )
{
  const a = test.assetFor( false );
  const srcRepositoryRemote = 'https://github.com/Wandalen/wModuleForTesting1.git';
  const srcCommit = '8e2aa80ca350f3c45215abafa07a4f2cd320342a';

  /* */

  let originalHistory = [];
  begin().then( () =>
  {
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    originalHistory = op;
    return null
  });

  /* - */

  begin().then( () =>
  {
    test.case = 'relative - now, state2 - to last commit, positive delta, periodic - one hour';
    return null;
  });
  a.appStart
  (
    `.commits.dates src:${ a.abs( '.' ) } state1:'#af36e28bc91b6f18e4babc810bbf5bc758ccf19f' `
    + `relative:now delta:3600000 periodic:'01:00:00' deviation:'00:10:00'`
  );
  a.ready.then( ( op ) =>
  {
    test.identical( op.exitCode, 0 );
    return _.git.repositoryHistoryToJson
    ({
      localPath : a.abs( '.' ),
      state1 : '#8d8d2d753046cad7a90324138e332d3fe1d798d2',
      state2 : '#HEAD',
    });
  });
  a.ready.then( ( op ) =>
  {
    test.identical( op.length, 14 );
    test.notIdentical( op, originalHistory );
    test.identical( op[ 13 ], originalHistory[ 13 ] );
    test.notIdentical( op[ 12 ], originalHistory[ 12 ] );
    test.identical( op[ 12 ].message, originalHistory[ 12 ].message );
    test.identical( op[ 12 ].author, originalHistory[ 12 ].author );
    test.notIdentical( op[ 0 ], originalHistory[ 0 ] );
    test.identical( op[ 0 ].message, originalHistory[ 0 ].message );
    test.identical( op[ 0 ].author, originalHistory[ 0 ].author );

    test.ge( Date.parse( op[ 11 ].date ) - Date.parse( op[ 12 ].date ), 2500000 );
    test.le( Date.parse( op[ 11 ].date ) - Date.parse( op[ 12 ].date ), 4500000 );
    test.ge( Date.parse( op[ 10 ].date ) - Date.parse( op[ 11 ].date ), 2500000 );
    test.le( Date.parse( op[ 10 ].date ) - Date.parse( op[ 11 ].date ), 4500000 );
    test.ge( Date.parse( op[ 0 ].date ) - Date.parse( op[ 1 ].date ), 2500000 );
    test.le( Date.parse( op[ 0 ].date ) - Date.parse( op[ 1 ].date ), 4500000 );
    return null;
  });

  /* - */

  return a.ready;

  /* */

  function begin()
  {
    a.ready.then( () => { a.fileProvider.filesDelete( a.abs( '.' ) ); return null });
    a.ready.then( () => { a.fileProvider.dirMake( a.abs( '.' ) ); return null });
    a.shell( `git clone ${ srcRepositoryRemote } ./` );
    return a.shell( `git reset --hard ${ srcCommit }` );
  }
}

// --
// declare
// --

const Proto =
{

  name : 'Tools.Repo.Ext',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,
  routineTimeOut : 60000,

  context :
  {
    suiteTempPath : null,
    appJsPath : null,
  },

  tests :
  {
    agree,
    agreeWithOptionMessage,
    agreeWithOptionBut,
    agreeWithOptionOnly,
    agreeWithOptionSrcDirPath,
    agreeWithOptionDstDirPath,

    migrate,
    migrateWithOptionOnMessage,
    migrateWithOptionBut,
    migrateWithOptionOnly,
    migrateWithOptionSrcDirPath,
    migrateWithOptionDstDirPath,

    commitsDates,
    commitsDatesWithOptionDelta,
    commitsDatesWithOptionDeltaAsString,
    commitsDatesWithOptionPeriodic,
    commitsDatesWithOptionDeviation,
  },
};

//

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
