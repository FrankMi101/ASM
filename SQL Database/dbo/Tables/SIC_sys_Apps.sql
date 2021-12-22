CREATE TABLE [dbo].[SIC_sys_Apps] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [AppID]       VARCHAR (20)  NOT NULL,
    [AppName]     VARCHAR (300) NULL,
    [Owners]      VARCHAR (250) NULL,
    [Developer]   VARCHAR (150) NULL,
    [StartDate]   SMALLDATETIME NULL,
    [EndDate]     SMALLDATETIME NULL,
    [ActiveFlag]  VARCHAR (1)   NULL,
    [AppUrl]      VARCHAR (200) NULL,
    [AppUrlTest]  VARCHAR (200) NULL,
    [AppUrlTrain] VARCHAR (200) NULL,
    [Comments]    VARCHAR (800) NULL,
    [lu_date]     DATETIME      NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_Apps] PRIMARY KEY CLUSTERED ([AppID] ASC)
);

