import * as luaparse from 'luaparse';

export class SimpleConfuser {
    private static stringToByteString(str: string) {
        const buffer = Buffer.from(str);
        let value = '';
        for (const byte of buffer) {
            value += `\\x${byte.toString(16).padStart(2, '0')}`;
        }
        return value;
    }

    private static formatExpression(expr: luaparse.Expression) {
        if (!expr) {
            return;
        }

        switch (expr.type) {
            case 'FunctionDeclaration':
                this.formatStatementList(expr.body);
                break;
            case 'Identifier':
                break;
            case 'StringLiteral':
                expr.raw = `'` + this.stringToByteString(expr.value) + `'`;
                break;
            case 'NumericLiteral':
                break;
            case 'BooleanLiteral':
                break;
            case 'NilLiteral':
                break;
            case 'VarargLiteral':
                break;
            case 'TableConstructorExpression':
                expr.fields.forEach(v => {
                    if (v.type === 'TableKey') {
                        this.formatExpression(v.key);
                    }
                    this.formatExpression(v.value);
                });
                break;
            case 'BinaryExpression':
            case 'LogicalExpression':
                this.formatExpression(expr.left);
                this.formatExpression(expr.right);
                break;
            case 'UnaryExpression':
                this.formatExpression(expr.argument);
                break;
            case 'MemberExpression':
                this.formatExpression(expr.base);
                break;
            case 'IndexExpression':
                this.formatExpression(expr.base);
                this.formatExpression(expr.index);
                break;
            case 'CallExpression':
            case 'TableCallExpression':
                this.formatExpression(expr.base);
                for (const argument of Object.values(expr.arguments)) {
                    this.formatExpression(argument);
                }
                break;
            case 'StringCallExpression':
                this.formatExpression(expr.base);
                this.formatExpression(expr.argument);
                break;
        }
    }

    private static formatExpressionList(exprs: luaparse.Expression[]) {
        if (!exprs) {
            return;
        }

        exprs.forEach(v => {
            this.formatExpression(v);
        });
    }

    private static formatStatementList(body: luaparse.Statement[]) {
        if (!body) {
            return;
        }

        body.forEach(v => {
            try {
                this.formatStatement(v);
            } catch (error) {
                console.log(error);
            }
        });
    }

    private static formatStatement(node: luaparse.Statement) {
        if (!node) {
            return;
        }

        switch (node.type) {
            case 'LabelStatement':
                break;
            case 'BreakStatement':
                break;
            case 'GotoStatement':
                break;
            case 'ReturnStatement':
                node.arguments.forEach(v => {
                    this.formatExpression(v);
                });
                break;
            case 'IfStatement':
                node.clauses.forEach(v => {
                    if (v.type != 'ElseClause') {
                        this.formatExpression(v.condition);
                    }
                    this.formatStatementList(v.body);
                });
                break;
            case 'WhileStatement':
                this.formatExpression(node.condition);
                this.formatStatementList(node.body);
                break;
            case 'DoStatement':
                this.formatStatementList(node.body);
                break;
            case 'RepeatStatement':
                this.formatExpression(node.condition);
                this.formatStatementList(node.body);
                break;
            case 'LocalStatement':
                this.formatExpressionList(node.init);
                break;
            case 'AssignmentStatement':
                node.variables.forEach(v => {
                    if (v.type === 'IndexExpression') {
                        this.formatExpression(v.index);
                    }
                });
                this.formatExpressionList(node.init);
                break;
            case 'CallStatement':
                this.formatExpression(node.expression);
                break;
            case 'FunctionDeclaration':
                this.formatStatementList(node.body);
                break;
            case 'ForNumericStatement':
                this.formatExpression(node.start);
                this.formatExpression(node.end);
                if (node.step) {
                    this.formatExpression(node.step);
                }
                break;
            case 'ForGenericStatement':
                this.formatExpressionList(node.iterators);
                this.formatStatementList(node.body);
                break;
        }
    }

    static parse(script: string) {
        const ast = luaparse.parse(script);
        this.formatStatementList(ast.body);
        return ast;
    }
}
