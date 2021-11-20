print('Rhelper 1.2: /rinfo for help');
-- DEFINE DBM
DBM_CORE_TIMER_PULL					= "Pull in";
DBM_CORE_TIMER_BREAK				= "Break time!";


-- Create timer frame
local cd_frame = CreateFrame("Frame","Rhelper",UIParent);
cd_frame:SetMovable(true);
cd_frame:RegisterForDrag("LeftButton");
cd_frame:EnableMouse(true);
cd_frame:SetUserPlaced(true);

cd_frame:SetFrameStrata("BACKGROUND");
cd_frame:SetWidth(100); -- Width
cd_frame:SetHeight(25); -- Height
cd_frame:SetScript("OnDragStart", cd_frame.StartMoving)
cd_frame:SetScript("OnDragStop", cd_frame.StopMovingOrSizing)
cd_frame:SetPoint("CENTER");
	
local bg_frame = cd_frame:CreateTexture(nil,"BACKGROUND");
bg_frame:SetAllPoints(cd_frame);
bg_frame:SetTexture(0, 0, 0, 0); -- BG color

cd_frame.texture = bg_frame;
		
local caption = cd_frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
caption:SetPoint("LEFT", 5,0);
		
local time_show = cd_frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
time_show:SetPoint("RIGHT", -5,0);
time_show:SetTextColor(1,1,1,1);
	
cd_frame:Show();

-- Function for Pull timer
local function pull_maker(timer)
	local var = tonumber(timer);
	if var > 0 and var <= 300 then
		
		bg_frame:SetTexture(0, 0, 0, 0.5); -- Add opacity for BG color
		caption:SetText("Pull:"); -- Set text for Frame
		
		local C = var;
		local w,f,T="raid",CnD or CreateFrame("Frame","CnD"),1;
		local text_show = "Pull in "..timer;
		local last_text_show = text_show;
		CreateDBMPizzaTimer(C, DBM_CORE_TIMER_PULL, true); -- Send DBM PULL timer broadcast
		f:SetScript("OnUpdate",function(s,e)T=T+e if T>1 then T=0 
		
		SendChatMessage(C>=0 and text_show,"RAID_WARNING");
		
		local mins = string.format("%02.f", math.floor(C / 60));
		local secs = string.format("%02.f", math.floor(C - mins * 60));
		
		time_show:SetText(mins..":"..secs); -- Count timer for Frame
		
		
		C=C-1; 
		
		if C == 240 then
			text_show = "Pull in 4 minutes";
		end
		
		if C == 180 then
			text_show = "Pull in 3 minutes";
		end
	
		if C == 120 then
			text_show = "Pull in 2 minutes";
		end
		
		if C == 60 then
			text_show = "Pull in 1 minute";
		end
		
		if C == 30 then
			text_show = "Pull in 30";
		end
		
		if C == 15 then
			text_show = "Pull in 15";
		end
		
		if C == 10 then
			text_show = "Pull in 10";
		end
		
		if C == 7 then
			text_show = "Pull in 7";
		end
		
		if C == 0 then
			text_show = ">> Pull NOW <<";
		end
		
		
		if C < 6 and C > 0 then
			text_show = "Pull in "..C;
		end
		
		if last_text_show == text_show then
			text_show = "";
		end
		
		last_text_show = text_show;
		
		if C<0 then f:Hide(); time_show:SetText(""); caption:SetText(""); bg_frame:SetTexture(0, 0, 0, 0); end end end); 
		f:Show();
	else
		print("Rhelper: Wrong number - type /rinfo for more help");
	end
end

SLASH_PULL1 = '/pull';
SlashCmdList["PULL"] = pull_maker;

-- Function for Break timer
local function break_maker(timer)
	local var = tonumber(timer);
	if var > 0 then
		if var <= 60 then
			
			bg_frame:SetTexture(0, 0, 0, 0.5); -- Add opacity for BG color
			caption:SetText("Break:"); -- Set text for Frame
			
			local C = var * 60;
			local w,f,T="raid",CnD or CreateFrame("Frame","CnD"),1;
			
			local text_show;
			
			if var == 1 then
				text_show = "The break time started, you have "..timer.." minute";
			else 
				text_show = "The break time started, you have "..timer.." minutes";
			end
			
			local last_text_show = text_show;
		 	CreateDBMPizzaTimer(C, DBM_CORE_TIMER_BREAK, true);  -- Send DBM BREAK timer broadcast

			f:SetScript("OnUpdate",function(s,e)T=T+e if T>1 then T=0 
		
			SendChatMessage(C>=0 and text_show,"RAID_WARNING");
			
			local mins = string.format("%02.f", math.floor(C / 60));
			local secs = string.format("%02.f", math.floor(C - mins * 60));
		
			time_show:SetText(mins..":"..secs); -- Count timer for Frame
			
			
			C=C-1;

			if C == 3000 then
				text_show = "The break time ends in 50 minutes";
			end
			if C == 2400 then
				text_show = "The break time ends in 40 minutes";
			end
		
			if C == 1800 then
				text_show = "The break time ends in 30 minutes";
			end
		
			if C == 1200 then
				text_show = "The break time ends in 20 minutes";
			end
		
			if C == 600 then
				text_show = "The break time ends in 10 minutes";
			end
		
			if C == 300 then
				text_show = "The break time ends in 5 minutes";
			end
		
			if C == 180 then
				text_show = "The break time ends in 3 minutes";
			end
		
			if C == 60 then
				text_show = "The break time ends in 1 minute";
			end
		
			if C == 30 then
				text_show = "The break time ends in 30 seconds";
			end
		
			if C == 0 then
				text_show = "Break time is over!";
			end
		
			if last_text_show == text_show then
				text_show = "";
			end
		
			last_text_show = text_show;
		
			if C<0 then f:Hide(); time_show:SetText(""); caption:SetText(""); bg_frame:SetTexture(0, 0, 0, 0); end end end); 
			f:Show();
		else
			print("Rhelper: The maximum length of the break is 60 minutes");
		end
	else 
		print("Rhelper: Wrong number - type /rinfo for more help");
	end
end

SLASH_BREAK1 = '/break';
SlashCmdList["BREAK"] = break_maker;

-- Function for clear all counters
local function clear_maker()
			local C = 1;
			local w,f,T="raid",CnD or CreateFrame("Frame","CnD"),1;
			
			CreateDBMPizzaTimer(1, DBM_CORE_TIMER_PULL, true); -- Send DBM PULL timer broadcast
			CreateDBMPizzaTimer(1, DBM_CORE_TIMER_BREAK, true);  -- Send DBM BREAK timer broadcast
	
			f:SetScript("OnUpdate",function(s,e)T=T+e if T>1 then T=0 
			C=C-1; 
		
			if C<0 then f:Hide()end end end);
			f:Show();
			
			bg_frame:SetTexture(0, 0, 0, 0); -- Remove opacity for BG color
			caption:SetText(""); -- Remove text for Frame
			time_show:SetText(""); -- Remove text for Frame
			
			SendChatMessage("-- All counters have been cleared --", "RAID");
			
	print('Rhelper: All counters have been cleared');
end

SLASH_RCLEAR1 = '/rclear';
SlashCmdList["RCLEAR"] = clear_maker;


-- DBM sync functions
function CreateDBMPizzaTimer(time, text, broadcast)
		text = text:sub(1, 16);
		if broadcast then
			sendSync("DBMv4-Pizza", ("%s\t%s"):format(time, text));
		end
	end

function sendSync(prefix, msg)
	local zoneType = select(2, IsInInstance());
	if zoneType == "pvp" or zoneType == "arena" then
		SendAddonMessage(prefix, msg, "BATTLEGROUND");
	elseif GetRealNumRaidMembers() > 0 then
		SendAddonMessage(prefix, msg, "RAID");
	elseif GetRealNumPartyMembers() > 0 then
		SendAddonMessage(prefix, msg, "PARTY");
	end
end	
-- DBM sync functions


local function info_maker()
	print('----------------');
	print('Rhelper 1.2');
	print('----------------');
	print('/pull <seconds | 0-300>');
	print('/break <minutes | 0-60>');
	print('/rclear - clear all counters');
	print('/rinfo');
	print('----------------');
	print('Blackytauru - www.michalmasarik.cz/addons');
end

SLASH_RINFO1 = '/rinfo';
SlashCmdList["RINFO"] = info_maker;