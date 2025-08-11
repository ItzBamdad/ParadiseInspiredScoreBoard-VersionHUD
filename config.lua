-- Ui BY: Mini Sara
-- ReCoded By: ItzBamdad
Config = {}

-- کلید باز کردن اسکوربورد (F9, F10, HOME, ... هر کلید استاندارد GTA) | Key To Open Scoreboard
Config.ScoreboardKey = 'F10'
-- دستور باز کردن اسکوربرد | Scoreboard Opening Command
Config.ScoreboardCommand = 'scoreboard'

-- تنظیمات نیرو های امنیتی مورد نیاز برای هر رابری | Robbery Icon Settings: Jobs Required
Config.Robs = {
    ["vehiclerob"] = {
        requiredJobs = {
            police = 2,
            sheriff = 1
        }
    },
    ["shop"] = {
        requiredJobs = {
            police = 1
        }
    },
    ["karaj"] = {
        requiredJobs = {
            police = 2
        }
    },
    ["cartel"] = {
        requiredJobs = {
            police = 3,
            fib = 1
        }
    },
    ["chicken"] = {
        requiredJobs = {
            police = 1
        }
    },
    ["javaheriPaleto"] = {
        requiredJobs = {
            police = 2
        }
    },
    ["miniBank"] = {
        requiredJobs = {
            police = 2,
            sheriff = 1
        }
    },
    ["javaheri"] = {
        requiredJobs = {
            police = 3
        }
    },
    ["yatch"] = {
        requiredJobs = {
            police = 3,
            coastguard = 1
        }
    },
    ["jr"] = {
        requiredJobs = {
            police = 1
        }
    },
    ["farm"] = {
        requiredJobs = {
            police = 1
        }
    },
    ["merryweather"] = {
        requiredJobs = {
            police = 2,
            army = 1
        }
    },
    ["shop_ru"] = {
        requiredJobs = {
            police = 1
        }
    },
    ["shop_fr"] = {
        requiredJobs = {
            police = 1
        }
    },
    ["shop_tw"] = {
        requiredJobs = {
            police = 1
        }
    },
    ["shop_co"] = {
        requiredJobs = {
            police = 1
        }
    }
}

-- زمان به‌روزرسانی دیتا (ثانیه) | Update Config
Config.UpdateInterval = 5
