CREATE TABLE [dbo].[SIC_sys_Employee_OverWriteSAP] (
    [IDs]          INT           NOT NULL,
    [SchoolYear]   VARCHAR (8)   NOT NULL,
    [UserID]       VARCHAR (30)  NOT NULL,
    [GroupID]      VARCHAR (50)  NOT NULL,
    [AppID]        VARCHAR (20)  NOT NULL,
    [ActiveFlag]   VARCHAR (10)  NULL,
    [StartDate]    DATETIME      NULL,
    [EndDate]      DATETIME      NULL,
    [GroupType]    VARCHAR (50)  NULL,
    [CPNum]        VARCHAR (10)  NULL,
    [FirstName]    VARCHAR (50)  NULL,
    [LastName]     VARCHAR (30)  NULL,
    [AppRole]      VARCHAR (50)  NULL,
    [PositionDesc] VARCHAR (250) NULL,
    [lu_Date]      DATETIME      NULL,
    [lu_User]      VARCHAR (50)  NULL,
    [lu_Function]  VARCHAR (50)  NULL
);

