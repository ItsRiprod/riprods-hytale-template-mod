package com.riprod.template;

import com.hypixel.hytale.logger.HytaleLogger;
import com.hypixel.hytale.server.core.plugin.JavaPlugin;
import com.hypixel.hytale.server.core.plugin.JavaPluginInit;

import javax.annotation.Nonnull;

/**
 * Plugin entry point.
 */
public class Template extends JavaPlugin {

    private static final HytaleLogger LOGGER = HytaleLogger.forEnclosingClass();

    /**
     * Creates the plugin. Keep this empty; do setup work in {@link #setup()}.
     *
     * @param init plugin init context supplied by the server
     */
    public Template(@Nonnull JavaPluginInit init) {
        super(init);
    }

    @Override
    protected void setup() {
        LOGGER.atInfo().log("Setting up %s %s", getName(), getManifest().getVersion());

        // Register configs, components, systems, events and commands here.
    }
}
