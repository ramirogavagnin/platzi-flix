from functools import lru_cache
from typing import Annotated

from fastapi import Depends
from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application settings using Pydantic Settings."""
    
    # Project information
    PROJECT_NAME: str = "Platziflix"
    VERSION: str = "0.1.0"
    
    # Environment
    ENVIRONMENT: str = Field(default="development", description="Application environment")
    DEBUG: bool = Field(default=True, description="Debug mode")
    
    # Database
    DATABASE_URL: str = Field(
        default="postgresql://user:password@localhost:5432/platziflix",
        description="PostgreSQL connection URL"
    )
    
    # Server
    HOST: str = Field(default="0.0.0.0", description="Server host")
    PORT: int = Field(default=8000, description="Server port")
    
    # API
    API_V1_STR: str = Field(default="/api/v1", description="API version prefix")
    
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore"
    )


@lru_cache
def get_settings() -> Settings:
    """Get cached settings instance."""
    return Settings()


# Type annotation for dependency injection
SettingsDep = Annotated[Settings, Depends(get_settings)] 