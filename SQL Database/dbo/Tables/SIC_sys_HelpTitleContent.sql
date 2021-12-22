CREATE TABLE [dbo].[SIC_sys_HelpTitleContent] (
    [IDs]         INT            IDENTITY (1, 1) NOT NULL,
    [Category]    VARCHAR (10)   NOT NULL,
    [Area]        VARCHAR (20)   NOT NULL,
    [ItemCode]    VARCHAR (20)   NOT NULL,
    [ContentType] NCHAR (20)     NOT NULL,
    [ContentText] VARCHAR (2000) NULL,
    [lu_function] VARCHAR (50)   NULL,
    [lu_user]     VARCHAR (20)   NULL,
    [lu_date]     SMALLDATETIME  NULL
);

