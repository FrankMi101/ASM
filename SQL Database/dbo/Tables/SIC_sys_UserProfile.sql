CREATE TABLE [dbo].[SIC_sys_UserProfile] (
    [UserID]      VARCHAR (50)   NULL,
    [FirstName]   VARCHAR (40)   NULL,
    [LastName]    VARCHAR (40)   NULL,
    [UserRole]    VARCHAR (50)   NULL,
    [UserScope]   VARCHAR (6)    NOT NULL,
    [ScopeCode]   VARCHAR (10)   NOT NULL,
    [SchoolCode]  VARCHAR (4)    NULL,
    [CPNum]       VARCHAR (8)    NULL,
    [PersonID]    VARCHAR (15)   NOT NULL,
    [Position]    VARCHAR (40)   NOT NULL,
    [ClassDesc]   VARCHAR (40)   NOT NULL,
    [Status]      VARCHAR (42)   NULL,
    [lu_Date]     DATETIME       NOT NULL,
    [lu_function] NVARCHAR (128) NULL,
    [lu_User]     VARCHAR (50)   NULL
);

