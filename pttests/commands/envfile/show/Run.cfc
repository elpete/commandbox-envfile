/**
 * My BDD Test
 */
component extends="testbox.system.BaseSpec" {

    /*********************************** LIFE CYCLE Methods ***********************************/

    /*
     * executes before all suites+specs in the run() method
     */
    void function beforeAll() {
    }

    /*
     * executes after all suites+specs in the run() method
     */
    void function afterAll() {
    }

    /*********************************** BDD SUITES ***********************************/

    void function run() {
        describe('The Show command should', function() {
            beforeEach(function() {
                testobj = createMock('commands.envfile.Show');

                mockPropertyFile = createEmptyMock('models.common');
                mockPropertyFile.$(method = 'load', returns = mockPropertyFile);
                mockPropertyFile.$(method = 'getsyncedNames', returns = ['fred', 'tim']);
                mockPropertyFile.$(method = 'get', returns = 'YO');
                mockCommon = createmock('models.common');
                mockCommon.$(method = 'printme', returns = true);
                mockCommon.$(
                    method = 'command',
                    returns = {
                        run: function() {
                        },
                        params: function() {
                            return {
                                run: function() {
                                }
                            };
                        }
                    }
                );
                testobj.$(
                    method = 'command',
                    returns = {
                        run: function() {
                        },
                        params: function() {
                            return {
                                run: function() {
                                }
                            };
                        }
                    }
                );
                testobj.$(method = 'getcwd', returns = '');
            });
            it('If the file doesn''t exist, print a message and exit', function() {
                mockCommon.$(method = 'doesFileExist', returns = false);
                testobj.setCommon(mockCommon);
                testobj.setpropertyFile(mockPropertyFile);
                testme = testobj.run();
                expect(mockCommon.$count('doesFileExist')).toBe(1);
                expect(mockCommon.$count('printme')).toBe(1);
            });

            it('If the file exists, load it into propertyFile and output the contents print a message and exit', function() {
                mockCommon.$(method = 'doesFileExist', returns = true);
                testobj.setCommon(mockCommon);
                testobj.setpropertyFile(mockPropertyFile);
                testme = testobj.run();
                expect(mockCommon.$count('doesFileExist')).toBe(1);
                expect(mockCommon.$count('printme')).toBe(2);
                expect(mockPropertyFile.$count('load')).toBe(1);
                expect(mockPropertyFile.$count('getsyncedNames')).toBe(1);
            });
        });
    }

}
