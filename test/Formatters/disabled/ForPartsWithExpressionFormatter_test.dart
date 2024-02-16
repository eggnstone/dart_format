

void main()
{
    /*TestTools.init();

    final List<TestGroupConfig> testGroupConfigs = <TestGroupConfig>[
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInForStatementInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: ';;',
            inputTrailing: ');}',
            name: 'ForPartsWithExpression / Simple'
        ),
        TestGroupConfig(
            inputNodeCreator: AstCreator.createForLoopPartsInForStatementInFunction,
            inputLeading: 'void f(){for(',
            inputMiddle: 'i=0;i<0;i++',
            inputTrailing: ');}',
            name: 'ForPartsWithExpression / With initializer, condition, and updater',
            astVisitors: <TestAstVisitor>[
                TestAssignmentExpressionVisitor(13, 'i=0'),
                TestBinaryExpressionVisitor(17, 'i<0'),
                TestPostfixExpressionVisitor(21, 'i++')
            ]
        )
    ];

    TestTools.runTestGroupsForFormatter(testGroupConfigs, 'ForPartsWithExpressionFormatter', ForPartsWithExpressionFormatter.new, StackTrace.current);*/
}
