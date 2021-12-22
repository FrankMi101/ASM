CREATE TABLE [dbo].[SIC_sys_UserGroup_FeederSchoolTeachers] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [SchoolYear]  VARCHAR (8)   NOT NULL,
    [SchoolCode]  VARCHAR (8)   NOT NULL,
    [AppID]       VARCHAR (10)  NOT NULL,
    [GroupID]     VARCHAR (100) NOT NULL,
    [MemberID]    VARCHAR (30)  NOT NULL,
    [FeederCode]  VARCHAR (10)  NULL,
    [StartDate]   SMALLDATETIME NULL,
    [EndDate]     SMALLDATETIME NULL,
    [Comments]    VARCHAR (500) NULL,
    [lu_date]     SMALLDATETIME NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (100) NULL,
    CONSTRAINT [PK_SIC_sys_UserGroup_FeederSchoolTeachers] PRIMARY KEY CLUSTERED ([SchoolYear] ASC, [SchoolCode] ASC, [AppID] ASC, [GroupID] ASC, [MemberID] ASC)
);

