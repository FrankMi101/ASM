CREATE TABLE [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc] (
    [ClassTypeIDDesc] VARCHAR (100) NOT NULL,
    [ClassTypeIDCode] VARCHAR (5)   NOT NULL,
    [UserRole]        VARCHAR (50)  NULL,
    [UserScope]       VARCHAR (50)  NULL,
    [lu_Date]         SMALLDATETIME NULL,
    [lu_User]         VARCHAR (50)  NULL,
    [lu_Function]     VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_UserProfileMatch_ClassTypeDesc] PRIMARY KEY CLUSTERED ([ClassTypeIDDesc] ASC, [ClassTypeIDCode] ASC)
);

