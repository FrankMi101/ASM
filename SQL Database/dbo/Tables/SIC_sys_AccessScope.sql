CREATE TABLE [dbo].[SIC_sys_AccessScope] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [AccessScope] VARCHAR (20)  NOT NULL,
    [Priority]    INT           NULL,
    [Comments]    VARCHAR (100) NULL,
    CONSTRAINT [PK_SIC_sys_UserAccessScope] PRIMARY KEY CLUSTERED ([AccessScope] ASC)
);

