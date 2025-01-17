<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit39d73f9560296bb2fc6185b17be09fbf
{
    public static $files = array (
        '51dfdfc249a1c61e80e9b405eb572af0' => __DIR__ . '/..' . '/lobtao/think-worker/src/command.php',
    );

    public static $prefixLengthsPsr4 = array (
        't' => 
        array (
            'think\\worker\\' => 13,
            'think\\composer\\' => 15,
        ),
        'a' => 
        array (
            'app\\' => 4,
        ),
        'W' => 
        array (
            'Workerman\\' => 10,
        ),
        'G' => 
        array (
            'GatewayWorker\\' => 14,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'think\\worker\\' => 
        array (
            0 => __DIR__ . '/..' . '/lobtao/think-worker/src',
        ),
        'think\\composer\\' => 
        array (
            0 => __DIR__ . '/..' . '/topthink/think-installer/src',
        ),
        'app\\' => 
        array (
            0 => __DIR__ . '/../..' . '/application',
        ),
        'Workerman\\' => 
        array (
            0 => __DIR__ . '/..' . '/workerman/workerman',
        ),
        'GatewayWorker\\' => 
        array (
            0 => __DIR__ . '/..' . '/workerman/gateway-worker/src',
        ),
    );

    public static $classMap = array (
        'GatewayWorker\\BusinessWorker' => __DIR__ . '/..' . '/workerman/gateway-worker/src/BusinessWorker.php',
        'GatewayWorker\\Gateway' => __DIR__ . '/..' . '/workerman/gateway-worker/src/Gateway.php',
        'GatewayWorker\\Lib\\Context' => __DIR__ . '/..' . '/workerman/gateway-worker/src/Lib/Context.php',
        'GatewayWorker\\Lib\\Db' => __DIR__ . '/..' . '/workerman/gateway-worker/src/Lib/Db.php',
        'GatewayWorker\\Lib\\DbConnection' => __DIR__ . '/..' . '/workerman/gateway-worker/src/Lib/DbConnection.php',
        'GatewayWorker\\Lib\\Gateway' => __DIR__ . '/..' . '/workerman/gateway-worker/src/Lib/Gateway.php',
        'GatewayWorker\\Protocols\\GatewayProtocol' => __DIR__ . '/..' . '/workerman/gateway-worker/src/Protocols/GatewayProtocol.php',
        'GatewayWorker\\Register' => __DIR__ . '/..' . '/workerman/gateway-worker/src/Register.php',
        'Workerman\\Autoloader' => __DIR__ . '/..' . '/workerman/workerman/Autoloader.php',
        'Workerman\\Connection\\AsyncTcpConnection' => __DIR__ . '/..' . '/workerman/workerman/Connection/AsyncTcpConnection.php',
        'Workerman\\Connection\\AsyncUdpConnection' => __DIR__ . '/..' . '/workerman/workerman/Connection/AsyncUdpConnection.php',
        'Workerman\\Connection\\ConnectionInterface' => __DIR__ . '/..' . '/workerman/workerman/Connection/ConnectionInterface.php',
        'Workerman\\Connection\\TcpConnection' => __DIR__ . '/..' . '/workerman/workerman/Connection/TcpConnection.php',
        'Workerman\\Connection\\UdpConnection' => __DIR__ . '/..' . '/workerman/workerman/Connection/UdpConnection.php',
        'Workerman\\Events\\Ev' => __DIR__ . '/..' . '/workerman/workerman/Events/Ev.php',
        'Workerman\\Events\\Event' => __DIR__ . '/..' . '/workerman/workerman/Events/Event.php',
        'Workerman\\Events\\EventInterface' => __DIR__ . '/..' . '/workerman/workerman/Events/EventInterface.php',
        'Workerman\\Events\\Libevent' => __DIR__ . '/..' . '/workerman/workerman/Events/Libevent.php',
        'Workerman\\Events\\React\\Base' => __DIR__ . '/..' . '/workerman/workerman/Events/React/Base.php',
        'Workerman\\Events\\React\\ExtEventLoop' => __DIR__ . '/..' . '/workerman/workerman/Events/React/ExtEventLoop.php',
        'Workerman\\Events\\React\\ExtLibEventLoop' => __DIR__ . '/..' . '/workerman/workerman/Events/React/ExtLibEventLoop.php',
        'Workerman\\Events\\React\\StreamSelectLoop' => __DIR__ . '/..' . '/workerman/workerman/Events/React/StreamSelectLoop.php',
        'Workerman\\Events\\Select' => __DIR__ . '/..' . '/workerman/workerman/Events/Select.php',
        'Workerman\\Events\\Swoole' => __DIR__ . '/..' . '/workerman/workerman/Events/Swoole.php',
        'Workerman\\Lib\\Timer' => __DIR__ . '/..' . '/workerman/workerman/Lib/Timer.php',
        'Workerman\\Protocols\\Frame' => __DIR__ . '/..' . '/workerman/workerman/Protocols/Frame.php',
        'Workerman\\Protocols\\Http' => __DIR__ . '/..' . '/workerman/workerman/Protocols/Http.php',
        'Workerman\\Protocols\\HttpCache' => __DIR__ . '/..' . '/workerman/workerman/Protocols/Http.php',
        'Workerman\\Protocols\\ProtocolInterface' => __DIR__ . '/..' . '/workerman/workerman/Protocols/ProtocolInterface.php',
        'Workerman\\Protocols\\Text' => __DIR__ . '/..' . '/workerman/workerman/Protocols/Text.php',
        'Workerman\\Protocols\\Websocket' => __DIR__ . '/..' . '/workerman/workerman/Protocols/Websocket.php',
        'Workerman\\Protocols\\Ws' => __DIR__ . '/..' . '/workerman/workerman/Protocols/Ws.php',
        'Workerman\\WebServer' => __DIR__ . '/..' . '/workerman/workerman/WebServer.php',
        'Workerman\\Worker' => __DIR__ . '/..' . '/workerman/workerman/Worker.php',
        'app\\index\\controller\\Index' => __DIR__ . '/../..' . '/application/index/controller/Index.php',
        'think\\composer\\LibraryInstaller' => __DIR__ . '/..' . '/topthink/think-installer/src/LibraryInstaller.php',
        'think\\composer\\Plugin' => __DIR__ . '/..' . '/topthink/think-installer/src/Plugin.php',
        'think\\composer\\Promise' => __DIR__ . '/..' . '/topthink/think-installer/src/Promise.php',
        'think\\composer\\ThinkExtend' => __DIR__ . '/..' . '/topthink/think-installer/src/ThinkExtend.php',
        'think\\composer\\ThinkFramework' => __DIR__ . '/..' . '/topthink/think-installer/src/ThinkFramework.php',
        'think\\composer\\ThinkTesting' => __DIR__ . '/..' . '/topthink/think-installer/src/ThinkTesting.php',
        'think\\worker\\Application' => __DIR__ . '/..' . '/lobtao/think-worker/src/Application.php',
        'think\\worker\\Cookie' => __DIR__ . '/..' . '/lobtao/think-worker/src/Cookie.php',
        'think\\worker\\Events' => __DIR__ . '/..' . '/lobtao/think-worker/src/Events.php',
        'think\\worker\\Http' => __DIR__ . '/..' . '/lobtao/think-worker/src/Http.php',
        'think\\worker\\Server' => __DIR__ . '/..' . '/lobtao/think-worker/src/Server.php',
        'think\\worker\\Session' => __DIR__ . '/..' . '/lobtao/think-worker/src/Session.php',
        'think\\worker\\command\\GatewayWorker' => __DIR__ . '/..' . '/lobtao/think-worker/src/command/GatewayWorker.php',
        'think\\worker\\command\\Server' => __DIR__ . '/..' . '/lobtao/think-worker/src/command/Server.php',
        'think\\worker\\command\\Worker' => __DIR__ . '/..' . '/lobtao/think-worker/src/command/Worker.php',
        'think\\worker\\facade\\Application' => __DIR__ . '/..' . '/lobtao/think-worker/src/facade/Application.php',
        'think\\worker\\facade\\Worker' => __DIR__ . '/..' . '/lobtao/think-worker/src/facade/Worker.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit39d73f9560296bb2fc6185b17be09fbf::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit39d73f9560296bb2fc6185b17be09fbf::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInit39d73f9560296bb2fc6185b17be09fbf::$classMap;

        }, null, ClassLoader::class);
    }
}
