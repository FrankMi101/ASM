CREATE TABLE [dbo].[SIC_sys_UserWorkingSchools] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [SchoolYear]  VARCHAR (8)   NOT NULL,
    [GroupType]   VARCHAR (50)  NOT NULL,
    [GroupID]     VARCHAR (50)  NOT NULL,
    [UserID]      VARCHAR (30)  NOT NULL,
    [AppID]       VARCHAR (30)  NULL,
    [AppRole]     VARCHAR (30)  NULL,
    [UserName]    VARCHAR (50)  NULL,
    [StartDate]   SMALLDATETIME NULL,
    [EndDate]     SMALLDATETIME NULL,
    [Comments]    VARCHAR (250) NULL,
    [ActiveFlag]  VARCHAR (10)  NULL,
    [lu_date]     SMALLDATETIME NULL,
    [lu_User]     VARCHAR (50)  NULL,
    [lu_Function] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_UserWorkingSchools] PRIMARY KEY CLUSTERED ([SchoolYear] ASC, [GroupType] ASC, [GroupID] ASC, [UserID] ASC)
);

