﻿CREATE TABLE [dbo].[SIC_sys_UserGroup_Members] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [SchoolCode]  VARCHAR (8)   NOT NULL,
    [AppID]       VARCHAR (10)  NOT NULL,
    [GroupID]     VARCHAR (100) NOT NULL,
    [GroupName]   VARCHAR (250) NULL,
    [GroupType]   VARCHAR (20)  NULL,
    [Permission]  VARCHAR (50)  NULL,
    [Active_flag] VARCHAR (10)  NULL,
    [Comments]    VARCHAR (800) NULL,
    [lu_date]     SMALLDATETIME NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (100) NULL,
    CONSTRAINT [PK_SIC_sys_UserGroup_Members_1] PRIMARY KEY CLUSTERED ([SchoolCode] ASC, [AppID] ASC, [GroupID] ASC)
);

