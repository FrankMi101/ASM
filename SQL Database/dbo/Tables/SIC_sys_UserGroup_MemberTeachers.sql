CREATE TABLE [dbo].[SIC_sys_UserGroup_MemberTeachers] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [SchoolCode]  VARCHAR (8)   NOT NULL,
    [AppID]       VARCHAR (10)  NOT NULL,
    [GroupID]     VARCHAR (100) NOT NULL,
    [MemberID]    VARCHAR (30)  NOT NULL,
    [StartDate]   SMALLDATETIME NULL,
    [EndDate]     SMALLDATETIME NULL,
    [Comments]    VARCHAR (500) NULL,
    [lu_date]     SMALLDATETIME NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (100) NULL,
    CONSTRAINT [PK_SIC_sys_UserGroup_MemberTeachers_1] PRIMARY KEY CLUSTERED ([SchoolCode] ASC, [AppID] ASC, [GroupID] ASC, [MemberID] ASC),
    CONSTRAINT [FK_SIC_sys_UserGroup_MemberTeachers_SIC_sys_UserGroup_Members] FOREIGN KEY ([SchoolCode], [AppID], [GroupID]) REFERENCES [dbo].[SIC_sys_UserGroup_Members] ([SchoolCode], [AppID], [GroupID])
);

