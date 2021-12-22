CREATE TABLE [dbo].[SIC_sys_ConvertFun_TestTable] (
    [IDS]         INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (250) NOT NULL,
    [ValueType]   VARCHAR (20)  NOT NULL,
    [lu_date]     DATETIME      NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (50)  NULL
);

