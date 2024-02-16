
void main()
{
    /*TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInForStatementInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: 'int i=0;i<0;i++',
            inputTrailing: ');}',
            name: 'ForPartsWithDeclarations / With initializer, condition, and updater',
            astVisitors: <TestAstVisitor>[
                TestVariableDeclarationListVisitor(13, 'int i=0'),
                TestBinaryExpressionVisitor(21, 'i<0'),
                TestPostfixExpressionVisitor(25, 'i++')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForPartsWithDeclarationsFormatter', ForPartsWithDeclarationsFormatter.new, StackTrace.current);*/
}
