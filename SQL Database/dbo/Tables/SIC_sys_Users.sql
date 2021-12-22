CREATE TABLE [dbo].[SIC_sys_Users] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [GroupID]     VARCHAR (20)  NULL,
    [UserID]      VARCHAR (30)  NULL,
    [UserName]    VARCHAR (50)  NULL,
    [AppID]       VARCHAR (10)  NULL,
    [Comment]     VARCHAR (200) NULL,
    [lu_date]     SMALLDATETIME NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (100) NULL
);

