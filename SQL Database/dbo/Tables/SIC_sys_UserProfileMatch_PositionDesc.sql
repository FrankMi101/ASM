CREATE TABLE [dbo].[SIC_sys_UserProfileMatch_PositionDesc] (
    [PositionDesc] VARCHAR (100)  NOT NULL,
    [UserRole]     VARCHAR (40)   NULL,
    [UserScope]    VARCHAR (40)   NULL,
    [lu_Date]      DATETIME       NULL,
    [lu_function]  NVARCHAR (128) NULL,
    [lu_User]      VARCHAR (13)   NULL,
    CONSTRAINT [PK_SIC_sys_UserProfileMatch_PositionDesc] PRIMARY KEY CLUSTERED ([PositionDesc] ASC)
);

