CREATE TABLE [dbo].[SIC_sys_AppsModels] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [AppID]       VARCHAR (20)  NOT NULL,
    [ModelID]     VARCHAR (20)  NOT NULL,
    [ModelName]   VARCHAR (300) NULL,
    [Developer]   VARCHAR (150) NULL,
    [Owners]      VARCHAR (250) NULL,
    [StartDate]   SMALLDATETIME NULL,
    [EndDate]     SMALLDATETIME NULL,
    [Comments]    VARCHAR (500) NULL,
    [lu_date]     DATETIME      NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_AppsModels] PRIMARY KEY CLUSTERED ([AppID] ASC, [ModelID] ASC),
    CONSTRAINT [FK_SIC_sys_AppsModels_SIC_sys_Apps] FOREIGN KEY ([AppID]) REFERENCES [dbo].[SIC_sys_Apps] ([AppID])
);

